//
//  MovieCell.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import UIKit

class MovieCell: UITableViewCell {
    
    static let identifier = Constants.UI.movieCellIdentifier
    override var reuseIdentifier: String?{
        Constants.UI.movieCellIdentifier
    }
    private var configuration: UIListContentConfiguration?
    var presenter: MovieCellPresenter?

    
    func configure(with presenter: MovieCellPresenter) {
        // choose default cell configuration( image and text components)
        self.presenter = presenter
        self.presenter?.delegate = self
        self.setConfiguration()
        self.presenter?.downloadImage()
    }
    
    private func setConfiguration(){
        self.configuration = self.defaultContentConfiguration()
        self.configuration?.text = presenter?.movie.title
        self.configuration?.textProperties.font =  UIFont.theme.subTitleFont
        self.configuration?.textProperties.color = .theme.primary
        configuration?.imageProperties.maximumSize =  CGSize(width: Constants.UI.movieCellImageHeight, height: Constants.UI.movieCellImageHeight)
        self.contentConfiguration = configuration
    }

}

extension MovieCell: MovieCellDelegate{
    func imageIsDownloaded(image: UIImage) {
        configuration?.imageProperties.maximumSize =  CGSize(width: Constants.UI.movieCellImageHeight, height: Constants.UI.movieCellImageHeight)
        self.configuration?.image = image
        self.contentConfiguration = configuration
    }
    
}
