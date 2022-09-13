//
//  MovieCellPresenterTests.swift
//  MoviesAppTests
//
//  Created by Marina on 13/09/2022.
//

import XCTest
@testable import MoviesApp

class MovieCellPresenterTests: XCTestCase {

    var cellPresenter: MovieCellPresenter!
    var model: MovieModel!

    override func setUp() {
        super.setUp()
        self.model = MovieModel.mock
        self.cellPresenter = MovieCellPresenter(movieModel: model)
    }
    
    override func tearDown() {
        self.cellPresenter = nil
        super.tearDown()
    }
    
    func testPresenterDefaultInstance() {
        XCTAssertNotNil(self.cellPresenter, "Default instance should not be nil.")
    }

    func testDownloadImage() throws {
        //create mock delegate
        let mockDelegate =  MockMovieCellDelegate(testCase: self)
        
        //Create presenter
        self.model = MovieModel.mock
        self.cellPresenter = MovieCellPresenter(movieModel: model)
        
        self.cellPresenter.delegate = mockDelegate
        mockDelegate.expectImage()
        
        //load image
        self.cellPresenter.downloadImage()
        
        //Wait for some time.
        waitForExpectations(timeout: 5)
        
        let result = try XCTUnwrap(mockDelegate.image)
        XCTAssertNotNil(result, "Image is nil even if the image is successfully downloaded")
    }
    
    func testDownloadInvalidImage() throws{
        let mockDelegate =  MockMovieCellDelegate(testCase: self)
        
        //Create presenter
        self.model = MovieModel.mockInvalidPath
        self.cellPresenter = MovieCellPresenter(movieModel: model)
        
        self.cellPresenter.delegate = mockDelegate
        self.cellPresenter.downloadImage()
        
        // wait for some time.
        RunLoop.current.run(until: Date(timeIntervalSinceNow: 0.5))
        
        let result = try XCTUnwrap((mockDelegate.image == nil))
        XCTAssert(result, "Image is not nil even if the image path is invalid")
    }

}
