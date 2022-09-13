//
//  RequestHandlerTests.swift
//  MoviesAppTests
//
//  Created by Marina on 13/09/2022.
//

import XCTest
@testable import MoviesApp

class RequestHandlerTests: XCTestCase {
    
    var requestHandler: RequestHandler!
    
    override func setUp() {
        super.setUp()
        self.requestHandler = RequestHandler()
    }
    
    override func tearDown() {
        self.requestHandler = nil
        super.tearDown()
    }
    
    func testRequestHandlerIsAbleToPerformTrendingMoviesAPI() {
        //Step1 - Given: When input Request-Url is valid.
        let api = APIRequest.getTrendingMovies(1)
        guard api.asRequest().url != nil else{
            XCTFail("Trending Movies API return invalid request with empty url.")
            return
        }
        
        // Create an expectation, RequestHandler request is an async-request.
        let expectation = self.expectation(description: "RequestHandler performing Trending Movies API")
        var movieResponse: MoviesResponse?
        var error: Error?
        
        //Step2 - When: RequestHandler is trying to perform a request.
        
        self.requestHandler.request(route: api) { (result : Result<MoviesResponse, RequestError>) in
            switch result {
            case .success(let success):
                movieResponse = success
            case .failure(let failure):
                error = failure
            }
            expectation.fulfill()
        }

        // Wait 2 seconds for the expectation to be fullfilled, or time out
        waitForExpectations(timeout: 2, handler: nil)

        //Step3 - Verify: that data is not nil & Error should be nil.
        XCTAssertNotNil(movieResponse, "Movies Api Response is nil even though server is responding valid data.")
        XCTAssertNil(error, "Error is not nil, if response is valid then Error should be nil.")
    }
    
    func testRequestHandlerIsAbleToPerformMovieDetailsAPIWithValidId() {
        //Step1 - Given: When input Request-Url is valid.
        let api = APIRequest.getMovieDetails(985939)
        guard api.asRequest().url != nil else{
            XCTFail("Movie Details API return invalid request with empty url.")
            return
        }
        
        // Create an expectation, RequestHandler request is an async-request.
        let expectation = self.expectation(description: "RequestHandler performing Trending Movies API")
        var movieDetails: MovieDetailsModel?
        var error: Error?
        
        //Step2 - When: RequestHandler is trying to perform request.
        
        self.requestHandler.request(route: api) { (result : Result<MovieDetailsModel, RequestError>) in
            switch result {
            case .success(let success):
                movieDetails = success
            case .failure(let failure):
                error = failure
            }
            expectation.fulfill()
        }

        // Wait 2 seconds for the expectation to be fullfilled, or time out
        waitForExpectations(timeout: 2, handler: nil)

        //Step3 - Verify: that data is not nil & Error should be nil.
        XCTAssertNotNil(movieDetails, "Movie Details Api Response is nil even though server is responding valid data.")
        XCTAssertNil(error, "Error is not nil, if response is valid then Error should be nil.")
    }
    
    func testRequestHandlerIsAbleToPerformMovieDetailsAPIWithInValidId() {
        //Step1 - Given: When input Request-Url is valid.
        let api = APIRequest.getMovieDetails(-100)
        guard api.asRequest().url != nil else{
            XCTFail("Movie Details API return invalid request with empty url.")
            return
        }
        
        // Create an expectation, RequestHandler request is an async-request.
        let expectation = self.expectation(description: "RequestHandler performing Trending Movies API")
        var movieDetails: MovieDetailsModel?
        var error: Error?
        
        //Step2 - When: RequestHandler is trying to perform request.
        
        self.requestHandler.request(route: api) { (result : Result<MovieDetailsModel, RequestError>) in
            switch result {
            case .success(let success):
                movieDetails = success
            case .failure(let failure):
                error = failure
            }
            expectation.fulfill()
        }

        // Wait 2 seconds for the expectation to be fullfilled, or time out
        waitForExpectations(timeout: 3, handler: nil)

        //Step3 - Verify: that data is not nil & Error should be nil.
        XCTAssertNil(movieDetails, "Movie Details Api Response is not nil even though server is responding error.")
        XCTAssertNotNil(error, "Error is nil, even though server is responding failure.")
    }
}
