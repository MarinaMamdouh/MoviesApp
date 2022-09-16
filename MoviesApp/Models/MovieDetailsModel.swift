//
//  MovieDetailsModel.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation

struct MovieDetailsModel: Codable {
    let englishTitle: String
    let originalTitle: String
    let overview: String
    let backdropPath: String
    let genres: [Genre]
    let vote: Double
    let votesCount: Int
    let budget: Int
    let revenue: Int
}

extension MovieDetailsModel {
    enum CodingKeys: String, CodingKey {
        case overview
        case revenue
        case budget
        case genres
        case englishTitle = "title"
        case originalTitle = "original_title"
        case backdropPath = "backdrop_path"
        case vote = "vote_average"
        case votesCount = "vote_count"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}
