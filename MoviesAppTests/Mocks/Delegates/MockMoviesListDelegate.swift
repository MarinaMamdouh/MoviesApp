//
//  MockMoviesListDelegate.swift
//  MoviesAppTests
//
//  Created by Marina on 13/09/2022.
//

import Foundation
import XCTest
@testable import MoviesApp

class MockMoviesListDelegate: MoviesListDelegate{
    private var expectation: XCTestExpectation?
    private let testCase: XCTestCase
    var updated: Bool?
    var errorMessage: String?
    var movieDetails: MovieDetailsModel?
    
    init(testCase: XCTestCase) {
        self.testCase = testCase
    }

    
    func expectUpdate(){
        expectation = testCase.expectation(description: "Expect Update")
    }
    
    func expectMovieDetails(){
        expectation = testCase.expectation(description: "Expect Movie Details")
    }
    
    func moviesListDidUpdate() {
        if expectation != nil {
            self.updated = true
        }
        expectation?.fulfill()
        expectation = nil
    }
    
    func showError(message: String) {
        if expectation != nil {
            self.updated = true
            self.errorMessage = message
        }
        expectation?.fulfill()
        expectation = nil
    }
    
    func showMovieDetails(details: MovieDetailsModel) {
        if expectation != nil{
            self.movieDetails = details
        }
        expectation?.fulfill()
        expectation = nil
    }
    
    
}
