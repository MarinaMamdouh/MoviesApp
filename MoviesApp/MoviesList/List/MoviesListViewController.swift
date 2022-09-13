//
//  ViewController.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import UIKit

class MoviesListViewController: UIViewController, UIViewControllerHandling {
    var tableView = UITableView()
    var presenter = MoviesListPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        styleUIComponents()
        autoLayoutUIComponents()
        setupViewModel()
        setupTable()
        presenter.loadMovies()
    }
    
    func styleUIComponents() {
        // Style NavigationBar
        self.title = "Movies"
        self.view.backgroundColor = .white
//        let titleLocalizedKey =  Constants.NavigationBarTitles.moviesList
//        title = String(localizedKey: titleLocalizedKey)
        // Style tableView
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func autoLayoutUIComponents() {
        
        // Auto Layout TableView
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            // top Constraint
            tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            // Leading Constraint
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            // Trailing Constraint
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            // Bottom Constraint
            tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }

}

// UItableView Delegates and Datasource

extension MoviesListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.moviesCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellContentHeight = CGFloat(Constants.UI.movieCellImageHeight)
        let heightPadding = CGFloat(Constants.UI.heightPadding)
        return cellContentHeight + heightPadding
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier) as? MovieCell else {
            return UITableViewCell()
        }
        let movieToBeDisplayed = presenter.movies[indexPath.row]
        let cellPresenter = MovieCellPresenter(movieModel: movieToBeDisplayed)
        cell.configure(with: cellPresenter)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieIndex =  indexPath.row
        presenter.getDetails(of: movieIndex)
    }
    
    func setupTable() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.identifier)
    }
    
}

// Scrolling Handling Methods

extension MoviesListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if didReachBottom(scrollView) && !presenter.isLoading {
            self.tableView.tableFooterView = createSpinner()
            presenter.loadMovies()
        }
    }
    
    func didReachBottom(_ scrollView: UIScrollView) -> Bool {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let remaingHeight = maximumOffset - currentOffset
        
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
        tableView.reloadData()
    }
    
    func showError(message: String) {
        self.showAlert(with: message)
    }
    
    func showMovieDetails(details: MovieDetailsModel) {
        // create the MovieDetails Module
        //let movieDetailsViewController = MovieDetailsViewController()
       // movieDetailsViewController.viewModel = MovieDetailsViewModel(details)
        // push it to the app navigationController
       // self.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func viewModelDidUpdate() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
        
    }
    
    func setupViewModel() {
        presenter.delegate = self
    }
    
}
