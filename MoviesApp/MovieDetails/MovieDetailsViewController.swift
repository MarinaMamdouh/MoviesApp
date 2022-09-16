//
//  MovieDetailsViewController.swift
//  MoviesApp
//
//  Created by Marina on 14/09/2022.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var presenter: MovieDetailsPresenter?
    // UIComponents
    var movieStatsView: MovieStatisticsView!
    
    let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = .theme.background
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let backDropImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.theme.largeTitleFont
        label.textColor = .theme.primary
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    let overviewTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = .theme.secondary
        textView.font = UIFont.theme.bodyFont
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let overViewTitleLabel: UILabel = {
        let label = UILabel()
        label.text = Constants.Texts.plotHeader
        label.textColor = .theme.primary
        label.font = UIFont.theme.subTitleFont
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.delegate = self
        movieStatsView = MovieStatisticsView(presenter: self.presenter!)
        titleLabel.text = presenter?.title
        overviewTextView.text = presenter?.overView
        self.view.backgroundColor = .theme.background
        autoLayoutUIComponents()
    }
}

extension MovieDetailsViewController: MovieDetailsDelegate{
    func imageIsDownloaded(image: UIImage) {
        self.backDropImageView.image = image
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
        self.vStackView.addArrangedSubview(movieStatsView)
        NSLayoutConstraint.activate([
            self.movieStatsView.centerXAnchor.constraint(equalTo: self.vStackView.centerXAnchor),
            self.movieStatsView.widthAnchor.constraint(equalTo: vStackView.widthAnchor),
            self.movieStatsView.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func layoutTitleLabel(){
        vStackView.addArrangedSubview(titleLabel)
    }
    
    func layoutImage() {
        self.vStackView.addArrangedSubview(backDropImageView)
        NSLayoutConstraint.activate([
            backDropImageView.widthAnchor.constraint(equalTo: self.vStackView.widthAnchor),
            // any Backdrop aspect ratio is W:H = 16:9
            backDropImageView.heightAnchor.constraint(equalTo: backDropImageView.widthAnchor, multiplier: 9.0/16.0),
            backDropImageView.centerXAnchor.constraint(equalTo: self.vStackView.centerXAnchor)
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


    
