//
//  APIs.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation

extension Constants{
    struct APIs{
        static let apiKeyParameter = URLQueryItem(name: "api_key", value: "c9856d0cb57c3f14bf75bdc6c063b8f3")
        
        static let baseMoviesEndPoint = "https://api.themoviedb.org/3/movie"
        
        static let trendingMoviesEndPoint = "https://api.themoviedb.org/3/discover/movie"
        
        static let downloadImageEndPoint = "https://image.tmdb.org/t/p"
        
        static let moviesRegionParameter = URLQueryItem(name: "region", value: "US")
        
        static let moviesLanguageParameter = URLQueryItem(name: "language", value: "en-US")
        
        static let pageParameterKey = "page"
        
        static let posterImageSize = "w185"
        static let backdropImageSize = "w780" //w500 is poor resolution
    }
}
