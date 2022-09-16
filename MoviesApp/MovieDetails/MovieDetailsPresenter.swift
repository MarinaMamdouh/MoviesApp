//
//  MovieDetailsPresenter.swift
//  MoviesApp
//
//  Created by Marina on 14/09/2022.
//

import Foundation
import UIKit

protocol MovieDetailsDelegate: AnyObject{
    func imageIsDownloaded(image: UIImage)
}


class MovieDetailsPresenter {
    var delegate: MovieDetailsDelegate?
    var title: String { movieDetails.englishTitle }
    var overView: String { movieDetails.overview }
    var ratingAttributedString: NSAttributedString { getFormattedVote() }
    var genresString: String { getGenres() }
    var revenueAttributedString: NSAttributedString { getFormattedRevenue() }
    
    
    private var movieDetails: MovieDetailsModel
    
    init(_ details: MovieDetailsModel) {
        self.movieDetails = details
        downloadBackdropImage()
    }
    
    private func downloadBackdropImage(){
        let downloadImageService = DownloadImageService()
        let backDropName = movieDetails.backdropPath
        let backdropSize = Constants.APIs.backdropImageSize
        downloadImageService.requestImage(name: backDropName, size: backdropSize) { [weak self] (result: Result<UIImage, RequestError>) in
            DispatchQueue.main.async {
                switch result{
                case .success(let recievedImage):
                    // tell the view taht image is retrieved
                    self?.delegate?.imageIsDownloaded(image: recievedImage)
                case .failure(_):
                    // do nothing as the default image is represented
                    // we can here call it again after 1 second
                    break
                }
            }
        }
    }
    
    // format the average votes of the movie * 6.7/ 10
    private func getFormattedVote() -> NSAttributedString {
        let formattedVoteString = NSMutableAttributedString()
        let voteScoreString = " " + String(format: "%.1f", movieDetails.vote) +
        " /\(Constants.Texts.tenNumber)"
        
        let voteScoreAttributedString = NSAttributedString(string: voteScoreString, attributes: [NSAttributedString.Key.font: UIFont.theme.subTitleBoldFont])
        formattedVoteString.append(voteScoreAttributedString)

        
        return formattedVoteString
    }
    
    // get Revenue formattedString ->  Box Office: $10,000,000
    private func getFormattedRevenue() -> NSAttributedString {
        let formattedRevenueString = NSMutableAttributedString(string: "\( Constants.Texts.boxOffice): ", attributes: [NSAttributedString.Key.font: UIFont.theme.bodyFontBold])
        let revenueString = "\(movieDetails.revenue.toMoney)"
        let revenueAttributedString = NSAttributedString(string: revenueString, attributes: [NSAttributedString.Key.font: UIFont.theme.smallFont])
        formattedRevenueString.append(revenueAttributedString)
        return formattedRevenueString
    }
    
    // get genres string -> Thriller, Drama, Action
    private func getGenres() -> String {
        let genresNames = getGenresNames()
        let genresString = genresNames.joined(separator: ", ")
        return genresString
    }
    
    // get array of genres names
    private func getGenresNames() -> [String] {
        var genresNames = [String]()

        for genre in movieDetails.genres {
            genresNames.append(genre.name)
        }
        return genresNames
    }
}
