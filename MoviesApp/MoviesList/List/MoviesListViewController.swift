//
//  ViewController.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import UIKit

class MoviesListViewController: UIViewController {
    // Note: You Have to use the convenience init or inject it to the ViewController in order not to create exception
    var presenter: MoviesListPresenter!
    // UI Components
    var titlLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.movies
        label.font = UIFont.theme.largeTitleFont
        label.textColor = .theme.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .theme.background
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var loadingIndicator: CircularLoadingIndicator = {
        let indicator = CircularLoadingIndicator()
        indicator.color = .theme.secondary
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    convenience init(presenter: MoviesListPresenter){
        self.init()
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .theme.background
        autoLayoutUIComponents()
        setupPresenter()
        setupTable()
        // Begin download movies from server
        startLoading()
        presenter.loadMovies()
    }
    
    private func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
    }
    
    private func startLoading(){
        loadingIndicator.animate()
        loadingIndicator.isHidden = false
        tableView.isHidden = true
    }
    
    private func stopLoading(){
        loadingIndicator.stopAnimation()
        loadingIndicator.isHidden = true
        tableView.isHidden = false
        // apply animation only on loading first patch of movies
        // this to avoid reoccurance of animation every time the table data is reloaded for smooth infinite scrolling
        if !presenter.moviesAreReLoading{
            tableView.entryAnimation(withDuration: 1.0, delay: 0.5)
        }
    }

}

// UItableView Delegates and Datasource

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.moviesCount
    }
    
    // setup the height of the cell
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellContentHeight = CGFloat(Constants.UI.movieCellImageHeight)
        let heightPadding = CGFloat(Constants.UI.heightPadding)
        return cellContentHeight + heightPadding
        
    }
    
    // load cells
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
            return UITableViewCell()
        }
        let movieToBeDisplayed = presenter.movies[indexPath.row]
        let cellPresenter = MovieCellPresenter(movieModel: movieToBeDisplayed)
        // inject the presenter to cell to configure it
        cell.configure(with: cellPresenter)
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }
    
    // cell is selected
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieIndex =  indexPath.row
        presenter.getDetails(of: movieIndex)
    }
    
}

// Scrolling Handling Methods

extension MoviesListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // check if we reached the bottom and presenter is not currently loading data from server
        if didReachBottom(scrollView) {
            let willLoad = presenter.displayedAllMovies()
            if willLoad{
                self.tableView.tableFooterView = createSpinner()
            }
        }
    }
    
    // check if we reach the bottom of the tableview
    func didReachBottom(_ scrollView: UIScrollView) -> Bool {
        let currentOffset = scrollView.contentOffset.y
        // get offset of the last cell(that is our threshhold)
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        // get the remaing Height to the threshold
        let remaingHeight = maximumOffset - currentOffset
        //if the remaing is less than or equal the spinner height
        if remaingHeight <= CGFloat(Constants.UI.spinnerViewHeight) {
            return true
        }
        
        return false
    }
    
    func createSpinner() -> UIView {
        let spinnerView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: self.view.frame.width, height: CGFloat(Constants.UI.spinnerViewHeight))))
        let spinnerActivity =  UIActivityIndicatorView()
        spinnerActivity.center = spinnerView.center
        spinnerView.addSubview(spinnerActivity)
        spinnerActivity.startAnimating()
        return spinnerView
    }
}

// ViewModel Updating Handling

extension MoviesListViewController: MoviesListDelegate {
    func moviesListDidUpdate() {
        stopLoading()
        tableView.reloadData()
    }
    
    func showError(message: String) {
        stopLoading()
        let tryAgainText = Constants.Texts.tryAgain
        let tryAgainAction =  UIAlertAction(title: tryAgainText, style: .cancel, handler: { _ in
            self.startLoading()
            self.presenter.loadMovies()
        })
        self.showAlert(with: message, action: tryAgainAction)
    }
    
    func showMovieDetails(details: MovieDetailsModel) {
        // create the MovieDetails Module
        let movieDetailsViewController = MovieDetailsViewController()
        movieDetailsViewController.presenter = MovieDetailsPresenter(details)
        movieDetailsViewController.modalPresentationStyle = .popover
        movieDetailsViewController.modalTransitionStyle = .coverVertical
        present(movieDetailsViewController, animated: true, completion: nil)
    }
    
    func viewModelDidUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    func setupPresenter() {
        presenter.delegate = self
    }
    
}

// Handling Auto Layout
extension MoviesListViewController{
    
    private func autoLayoutUIComponents() {
        // Auto Layout TableView
        self.view.addSubview(tableView)
        self.view.addSubview(titlLabel)
        NSLayoutConstraint.activate([
            // top Constraint
            titlLabel.topAnchor.constraint(equalToSystemSpacingBelow: self.view.safeAreaLayoutGuide.topAnchor, multiplier: 2),
            titlLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: self.view.leadingAnchor, multiplier: 2),
            titlLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: self.view.trailingAnchor, multiplier: 1),
            tableView.topAnchor.constraint(equalTo: self.titlLabel.bottomAnchor, constant: 20),
            // Leading Constraint
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            // Trailing Constraint
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            // Bottom Constraint
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        layoutLoadingIndicator()
        
    }
    
    private func layoutLoadingIndicator(){
        self.view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20),
            loadingIndicator.widthAnchor.constraint(equalToConstant: CGFloat(Constants.UI.loadingIndicatorSize)),
            loadingIndicator.heightAnchor.constraint(equalToConstant: CGFloat(Constants.UI.loadingIndicatorSize))
        ])
    }
}
