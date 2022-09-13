//
//  MockMovieModel.swift
//  MoviesAppTests
//
//  Created by Marina on 13/09/2022.
//

import Foundation
@testable import MoviesApp

extension MovieModel{
    static let mock = MovieModel(id: 985939, originalTitle: "Fall", title: "Fall", language: "En", imagePath: "/9f5sIJEgvUpFv0ozfA6TurG4j22.jpg")
    
    static let mockInvalidPath = MovieModel(id: 985939, originalTitle: "Fall", title: "Fall", language: "En", imagePath: "/9f5sIJEgvUpFv0ozfA6Tur")
}

