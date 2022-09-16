//
//  MovieStatisticsView.swift
//  MoviesApp
//
//  Created by Marina on 16/09/2022.
//

import UIKit

class MovieStatisticsView: UIView {
    var presenter: MovieDetailsPresenter
    var stackView = UIStackView()
    var voteLabel = UILabel()
    var genresLabel = UILabel()
    var boxOfficeLabel = UILabel()
    
    init(presenter: MovieDetailsPresenter){
        self.presenter = presenter
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        styleUIComponents()
        autoLayoutUIComponents()
    }
}

// Main UI Handling
extension MovieStatisticsView: UIViewControllerHandling {
    func styleUIComponents() {
        styleStackView()
        styleVoteLabel()
        styleBoxOfficeLabel()
        styleGenresLabel()
        
    }
    
    func autoLayoutUIComponents() {
        layoutStackView()
    }
    
}

// Styling UI Components
extension MovieStatisticsView {
    func styleStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        //stackView.spacing = CGFloat(Constants.UI.verticalSpacing)
    }
    
    func styleVoteLabel() {
        let attachment = NSTextAttachment()
        let config = UIImage.SymbolConfiguration(hierarchicalColor: .orange)
        attachment.image = UIImage(systemName: "star.fill", withConfiguration: config)

        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = presenter.ratingAttributedString
        imageString.append(textString)
        voteLabel.attributedText = imageString
        voteLabel.textColor = .theme.primary
        voteLabel.textAlignment = .center
        voteLabel.numberOfLines = 2
        voteLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func styleBoxOfficeLabel() {
        boxOfficeLabel.attributedText = presenter.revenueAttributedString
        boxOfficeLabel.textAlignment = .center
        boxOfficeLabel.textColor = .theme.primary
        boxOfficeLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    
    func styleGenresLabel() {
        genresLabel.text = presenter.genresString
        genresLabel.font = .theme.subTitleFont
        genresLabel.numberOfLines = 0
        genresLabel.textAlignment = .center
        genresLabel.textColor = .theme.secondary
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
    }
}

// Handling Auto Layout of UI Components
extension MovieStatisticsView {
    func layoutStackView() {
        self.addSubview(stackView)
        addViewsToStack()
        NSLayoutConstraint.activate([
            self.stackView.topAnchor.constraint(equalTo: self.topAnchor),
            self.stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    func addViewsToStack() {
        stackView.addArrangedSubview(genresLabel)
        stackView.addArrangedSubview(voteLabel)
        stackView.addArrangedSubview(boxOfficeLabel)
        
    }
}

