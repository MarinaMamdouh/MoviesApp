//
//  MovieCellPresenter.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation
import UIKit

protocol MovieCellDelegate: AnyObject{
    func imageIsDownloaded(image: UIImage)
}

final class MovieCellPresenter{
    private(set) var movie: MovieModel
    weak var delegate: MovieCellDelegate?
    
    private let downloadImageService = DownloadImageService()
    init(movieModel: MovieModel){
        movie = movieModel
    }
    
    func downloadImage(){
        let path = movie.imagePath
        downloadImageService.requestImage(name: path, size: Constants.APIs.posterImageSize) { [weak self] (result: Result<UIImage, RequestError>) in
            // go to the main thread
            DispatchQueue.main.async {
                switch result{
                case .success(let recievedImage):
                    // tell the view taht image is retrieved
                    self?.delegate?.imageIsDownloaded(image: recievedImage)
                case .failure(_):
                    // do nothing as the default image is represented
                    break
                }
            }

        }
    }
    
}
