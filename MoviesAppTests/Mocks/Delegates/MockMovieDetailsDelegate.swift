//
//  MockMovieDetailsDelegate.swift
//  MoviesAppTests
//
//  Created by Marina on 16/09/2022.
//

import Foundation
import UIKit
import XCTest
@testable import MoviesApp

class MockMovieDetailsDelegate: MovieDetailsDelegate{
    
    private var expectation: XCTestExpectation?
    private let testCase: XCTestCase
    var image: UIImage?
    
    init(testCase: XCTestCase) {
        self.testCase = testCase
    }
    
    func expectImage(){
        expectation = testCase.expectation(description: "Expect Image")
    }
    
    func imageIsDownloaded(image: UIImage) {
        if expectation != nil {
            self.image = image
        }
        expectation?.fulfill()
        expectation = nil
    }
    
}
