//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Marina on 14/09/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController, UIViewControllerHandling {
    var presenter: MovieDetailsPresenter?
    // UIComponents
    var vStackView =  UIStackView()
    var backDropImageView = UIImageView()
    var overviewTextView = UITextView()
    var overViewTitleLabel = UILabel()
    var titleLabel = UILabel()
    //var movieStatsView = MovieStatisticsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.delegate = self
        styleUIComponents()
        autoLayoutUIComponents()
    }
}

extension MovieDetailsViewController: MovieDetailsDelegate{
    func imageIsDownloaded(image: UIImage) {
        self.backDropImageView.image = image
    }
    
}

// Styling UIComponents
extension MovieDetailsViewController {
    
    func styleUIComponents() {
        self.view.backgroundColor = .theme.background
        styleStackView()
        styleMovieImage()
        styleMovieTitleLabel()
        styleMovieStatsView()
        styleMovieDescTextView()
    }
    
    func styleStackView(){
        vStackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        vStackView.backgroundColor = .theme.background
        vStackView.alignment = .fill
        vStackView.axis = .vertical
        vStackView.distribution = .fill
        vStackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleMovieTitleLabel() {
        titleLabel.text = presenter?.title
        titleLabel.font = UIFont.theme.largeTitleFont
        titleLabel.textColor = .theme.primary
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
    }
    
    func styleMovieStatsView() {
//        movieStatsView.viewModel = self.viewModel
//        movieStatsView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleMovieImage() {
        backDropImageView.contentMode = .scaleAspectFill
        backDropImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleMovieDescTextView() {
        overViewTitleLabel.text = Constants.Texts.plotHeader
        overViewTitleLabel.textColor = .theme.primary
        overViewTitleLabel.font = UIFont.theme.subTitleFont
        overviewTextView.backgroundColor = .clear
        overviewTextView.text = presenter?.overView
        overviewTextView.textColor = .theme.primary
        overviewTextView.font = UIFont.theme.bodyFont
        overviewTextView.translatesAutoresizingMaskIntoConstraints = false
    }
    
}

// Handling Layout of UIComponents
extension MovieDetailsViewController {
    
    func autoLayoutUIComponents() {
        layoutVStackView()
        layoutImage()
        layoutTitleLabel()
        layoutStatsView()
        layoutDescription()
    }
    
    func layoutVStackView(){
        self.view.addSubview(vStackView)
        NSLayoutConstraint.activate([
            vStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            vStackView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            vStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            vStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    func layoutStatsView() {
        //self.view.addSubview(movieStatsView)
//        NSLayoutConstraint.activate([
//            movieStatsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
//            movieStatsView.leadingAnchor.constraint(equalToSystemSpacingAfter: moviePosterImageView.trailingAnchor, multiplier: 1),
//            self.view.trailingAnchor.constraint(equalToSystemSpacingAfter: movieStatsView.trailingAnchor, multiplier: 2),
//            movieStatsView.bottomAnchor.constraint(equalTo: moviePosterImageView.bottomAnchor)
//        ])
    }
    
    func layoutTitleLabel(){
        vStackView.addArrangedSubview(titleLabel)
    }
    
    func layoutImage() {
        self.vStackView.addArrangedSubview(backDropImageView)
        NSLayoutConstraint.activate([
            backDropImageView.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            backDropImageView.heightAnchor.constraint(equalTo: backDropImageView.widthAnchor, multiplier: 2.0/3.0),
            backDropImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func layoutDescription() {
        self.vStackView.addArrangedSubview(overViewTitleLabel)
        self.vStackView.addArrangedSubview(overviewTextView)
        NSLayoutConstraint.activate([
            overViewTitleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: vStackView.leadingAnchor, multiplier: 1),
            overViewTitleLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: vStackView.trailingAnchor, multiplier: 1),
            overviewTextView.leadingAnchor.constraint(equalToSystemSpacingAfter: vStackView.leadingAnchor, multiplier: 1),
            overviewTextView.trailingAnchor.constraint(equalToSystemSpacingAfter: vStackView.trailingAnchor, multiplier: 1),
        ])
    }
}


    
