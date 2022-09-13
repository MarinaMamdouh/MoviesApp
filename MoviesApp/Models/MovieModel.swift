//
//  MovieModel.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation

struct MovieModel: Codable {
    let id: Int
    let originalTitle: String
    let englishTitle: String
    let language: String
    let imagePath: String
    
}

extension MovieModel {
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case englishTitle = "title"
        case language = "original_language"
        case imagePath = "poster_path"
    }
}
