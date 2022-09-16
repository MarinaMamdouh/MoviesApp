//
//  MovieDetailsPresenterTests.swift
//  MoviesAppTests
//
//  Created by Marina on 16/09/2022.
//

import XCTest
@testable import MoviesApp

class MovieDetailsPresenterTests: XCTestCase {
    
    var detailsPresenter: MovieDetailsPresenter!
    var model: MovieDetailsModel!

    override func setUp() {
        super.setUp()
        self.model = MovieDetailsModel.mock
        self.detailsPresenter = MovieDetailsPresenter(model)
    }
    
    override func tearDown() {
        self.detailsPresenter = nil
        super.tearDown()
    }
    
    func testPresenterDefaultInstance() {
        XCTAssertNotNil(self.detailsPresenter, "Default instance should not be nil.")
    }
    
    func testDownloadImage() throws {
        //create mock delegate
        let mockDelegate =  MockMovieDetailsDelegate(testCase: self)
        
        //Create presenter
        self.model = MovieDetailsModel.mock
        self.detailsPresenter = MovieDetailsPresenter(model)
        
        self.detailsPresenter.delegate = mockDelegate
        mockDelegate.expectImage()
        
        
        //Wait for some time.
        waitForExpectations(timeout: 5)
        
        let result = try XCTUnwrap(mockDelegate.image)
        XCTAssertNotNil(result, "Image is nil even if the image is successfully downloaded")
    }
    
    func testDownloadInvalidImage() throws{
        let mockDelegate =  MockMovieDetailsDelegate(testCase: self)
        
        //Create presenter
        self.model = MovieDetailsModel.mockInvalidPath
        self.detailsPresenter = MovieDetailsPresenter(model)
        
        self.detailsPresenter.delegate = mockDelegate
        
        // wait for some time.
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
        
        let result = try XCTUnwrap((mockDelegate.image == nil))
        XCTAssert(result, "Image is not nil even if the image path is invalid")
    }

}
