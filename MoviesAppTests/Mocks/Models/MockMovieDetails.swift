//
//  MockMovieDetails.swift
//  MoviesAppTests
//
//  Created by Marina on 16/09/2022.
//

import Foundation
@testable import MoviesApp

extension MovieDetailsModel{
    static let mock = MovieDetailsModel(englishTitle: "EMockMovie", originalTitle: "MockMovie", overview: "Mock OverView", backdropPath: "/2RSirqZG949GuRwN38MYCIGG4Od.jpg", releaseDate: "2022-01-01", genres: [Genre.action, Genre.thriller], vote: 6.5, votesCount: 301, budget: 2000000, revenue: 1200000)
    
    static let mockInvalidPath = MovieDetailsModel(englishTitle: "EInvalidPathMockMovie", originalTitle: "InvalidPathMockMovie", overview: "Mock OverView InvalidPath", backdropPath: "/2RSirqZG949GuRwN38MYCIGG4Od", releaseDate: "2022-01-01", genres: [Genre.action, Genre.thriller], vote: 6.5, votesCount: 301, budget: 2000000, revenue: 1200000)
}

extension Genre{
    static let action = Genre(id: 1, name: "Action")
    static let thriller = Genre(id: 2, name: "Thriller")
}
