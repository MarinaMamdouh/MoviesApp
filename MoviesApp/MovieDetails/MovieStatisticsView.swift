//
//  MovieStatisticsView.swift
//  MoviesApp
//
//  Created by Marina on 16/09/2022.
//

import UIKit

class MovieStatisticsView: UIView {
    var presenter: MovieDetailsPresenter
    
    // UI Components
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var voteLabel: UILabel = {
        let label = UILabel()
        label.textColor = .theme.primary
        label.textAlignment = .center
        label.numberOfLines = 2 // to hold rating and votes count
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var genresLabel: UILabel = {
        let label = UILabel()
        label.font = .theme.subTitleFont
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .theme.secondary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .theme.primary
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(presenter: MovieDetailsPresenter){
        self.presenter = presenter
        super.init(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        loadDataToUI()
        autoLayoutUIComponents()
    }
    
    func loadDataToUI(){
        // Vote Label
        let attachment = NSTextAttachment()
        let config = UIImage.SymbolConfiguration(hierarchicalColor: .orange)
        attachment.image = UIImage(systemName: "star.fill", withConfiguration: config)

        let imageString = NSMutableAttributedString(attachment: attachment)
        let textString = presenter.ratingAttributedString
        imageString.append(textString)
        voteLabel.attributedText = imageString
        // Genres Label
        genresLabel.text = presenter.genresString
        // Box Office Label
        boxOfficeLabel.attributedText = presenter.revenueAttributedString
    }
}


// Handling Auto Layout of UI Components
extension MovieStatisticsView {
    
    func autoLayoutUIComponents() {
        layoutStackView()
    }
    
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

