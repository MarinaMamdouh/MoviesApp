//
//  DownloadImageServiceTests.swift
//  MoviesAppTests
//
//  Created by Marina on 13/09/2022.
//

import XCTest
import UIKit
@testable import MoviesApp

class DownloadImageServiceTests: XCTestCase {
    
    var imageService: DownloadImageService!

    override func setUp() {
        super.setUp()
        self.imageService = DownloadImageService()
    }
    
    override func tearDown() {
        self.imageService = nil
        super.tearDown()
    }
    
    func testDownloadImageServiceWithValidImagePathAndSize() throws {
        //Step1 - Given: When input Request-Url is valid.
        let validImagePath = "/9f5sIJEgvUpFv0ozfA6TurG4j22.jpg"
        let validImageSize = "w185"
        let api = APIRequest.getImage(validImagePath, validImageSize)
        guard api.asRequest().url != nil else{
            XCTFail("Download Image request return invalid request with empty url.")
            return
        }
        
        // Create an expectation, RequestHandler request is an async-request.
        let expectation = self.expectation(description: "DownloadImageService request image")
        var image: UIImage?
        var error: Error?
        
        //Step2 - When: RequestHandler is trying to perform a request.
        
        self.imageService.requestImage(name: validImagePath, size: validImageSize){ (result : Result<UIImage, RequestError>) in
            switch result {
            case .success(let success):
                image = success
            case .failure(let failure):
                error = failure
            }
            expectation.fulfill()
        }

        // Wait 2 seconds for the expectation to be fullfilled, or time out
        waitForExpectations(timeout: 2, handler: nil)

        //Step3 - Verify: that data is not nil & Error should be nil.
        XCTAssertNotNil(image, "Download Image url Response is nil even though server is responding valid data.")
        XCTAssertNil(error, "Error is not nil, if response is valid then Error should be nil.")
    }
    
    func testDownloadImageServiceWithInValidImagePath() throws {
        //Step1 - Given: When input Request-Url is valid.
        let inValidImagePath = ""
        let validImageSize = "w185"
        let api = APIRequest.getImage(inValidImagePath, validImageSize)
        guard api.asRequest().url != nil else{
            XCTFail("Download Image request return invalid request with empty url.")
            return
        }
        
        // Create an expectation, RequestHandler request is an async-request.
        let expectation = self.expectation(description: "DownloadImageService request image")
        var image: UIImage?
        var error: Error?
        
        //Step2 - When: RequestHandler is trying to perform a request.
        
        self.imageService.requestImage(name: inValidImagePath, size: validImageSize){ (result : Result<UIImage, RequestError>) in
            switch result {
            case .success(let success):
                image = success
            case .failure(let failure):
                error = failure
            }
            expectation.fulfill()
        }

        // Wait 2 seconds for the expectation to be fullfilled, or time out
        waitForExpectations(timeout: 2, handler: nil)

        //Step3 - Verify: that data is not nil & Error should be nil.
        XCTAssertNil(image, "Download Image url Response is not nil even though server is responding with error.")
        XCTAssertNotNil(error, "Error is  nil even though server is responding with failure.")
    }



}
