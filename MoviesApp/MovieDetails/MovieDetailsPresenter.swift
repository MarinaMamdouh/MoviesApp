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
    var genresAttributedString: NSAttributedString { getGenres() }
    var revenueAttributedString: NSAttributedString { getFormattedRevenue() }
    var budgetAttributedString: NSAttributedString { getFormattedBudget() }
    
    
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
        let voteScoreString = " \(movieDetails.vote)/" +
        "\(Constants.Texts.tenNumber)"
        
        let voteScoreAttributedString = NSAttributedString(string: voteScoreString, attributes: [NSAttributedString.Key.font: UIFont.theme.subTitleBoldFont])
        formattedVoteString.append(voteScoreAttributedString)
        
        let voteCountString = "\n(\(movieDetails.votesCount) " +
        "\(Constants.Texts.votes)"
        let voteCountAttributedString = NSAttributedString(string: voteCountString, attributes: [NSAttributedString.Key.font: UIFont.theme.smallFont])
        formattedVoteString.append(voteCountAttributedString)
        
        return formattedVoteString
    }
    
    func getFormattedRevenue() -> NSAttributedString {
        let formattedRevenueString = NSMutableAttributedString(string: "\( Constants.Texts.boxOffice): ", attributes: [NSAttributedString.Key.font: UIFont.theme.bodyFontBold])
        let revenueString = "\(movieDetails.revenue.toMoney)"
        let revenueAttributedString = NSAttributedString(string: revenueString, attributes: [NSAttributedString.Key.font: UIFont.theme.smallFont])
        formattedRevenueString.append(revenueAttributedString)
        return formattedRevenueString
    }
    
    func getFormattedBudget() -> NSAttributedString {
        let formattedBudgetString = NSMutableAttributedString(string: "\( Constants.Texts.budget): ", attributes: [NSAttributedString.Key.font: UIFont.theme.bodyFontBold])
        
        let budgetString = "\(movieDetails.budget.toMoney)"
        let budgetAttributedString = NSAttributedString(string: budgetString, attributes: [NSAttributedString.Key.font: UIFont.theme.smallFont])
        
        formattedBudgetString.append(budgetAttributedString)
        return formattedBudgetString
    }
    
    func getGenres() -> NSAttributedString {
        let formattedGenreString = NSMutableAttributedString(string: "\( Constants.Texts.genres): ", attributes: [NSAttributedString.Key.font: UIFont.theme.bodyFontBold])
        
        let genresNames = getGenresNames()
        let genresString = genresNames.joined(separator: ", ")
        let genresAttributedString = NSAttributedString(string: genresString, attributes: [NSAttributedString.Key.font: UIFont.theme.smallFont])
        
        formattedGenreString.append(genresAttributedString)
        return formattedGenreString
    }
    
    private func getGenresNames() -> [String] {
        var genresNames = [String]()

        for genre in movieDetails.genres {
            genresNames.append(genre.name)
        }
        return genresNames
    }
}
