//
//  MoviesListPresenterTests.swift
//  MoviesAppTests
//
//  Created by Marina on 13/09/2022.
//

import XCTest
@testable import MoviesApp

class MoviesListPresenterTests: XCTestCase {
    
    var listPresenter: MoviesListPresenter!

    override func setUp() {
        super.setUp()
        self.listPresenter = MoviesListPresenter()
    }
    
    override func tearDown() {
        self.listPresenter = nil
        super.tearDown()
    }
    
    func testPresenterDefaultInstance() {
        XCTAssertNotNil(self.listPresenter, "Default instance should not be nil.")
    }
    
    func testLoadMoviesWithData() throws {
        //create mock delegate
        let mockDelegate =  MockMoviesListDelegate(testCase: self)
        
        //Create presenter
        self.listPresenter = MoviesListPresenter()
        XCTAssertEqual(self.listPresenter.isLoading, false , "MoviesListPresenter's isLoading flag is true even if presenter is not loading data")
        self.listPresenter.delegate = mockDelegate
        mockDelegate.expectUpdate()
        
        //load movies
        self.listPresenter.loadMovies()
        XCTAssertEqual(self.listPresenter.isLoading, true, "MoviesListPresenter's isLoading flag is false even if presenter is loading data")
        
        //Wait for some time.
        waitForExpectations(timeout: 2)
        
        let result = try XCTUnwrap(mockDelegate.updated)
        XCTAssertEqual(result, true, "There is no update returned either movies or error (Serious issue needs to be solved)")
        XCTAssertEqual(self.listPresenter.isLoading, false, "MoviesListPresenter's isLoading flag is true even if presenter is completed loading data")
        
    }
    
    func testGetMovieDetails() throws{
        //create mock delegate
        let mockDelegate =  MockMoviesListDelegate(testCase: self)
        
        //Create presenter
        self.listPresenter = MoviesListPresenter()
        self.listPresenter.delegate = mockDelegate
        mockDelegate.expectUpdate()
        
        // load movies
        self.listPresenter.loadMovies()
        
        //Wait for some time.
        waitForExpectations(timeout: 2)
        
        
        let count = self.listPresenter.moviesCount
        if count > 0{
            // select movie of index = 0
            let selectedMovie = 0
            let movieTitle = self.listPresenter.movies[selectedMovie].originalTitle
            mockDelegate.expectMovieDetails()
            
            // load details
            self.listPresenter.getDetails(of: selectedMovie)
            //Wait for some time.
            waitForExpectations(timeout: 2)
            
            let result = try XCTUnwrap(mockDelegate.movieDetails)
            XCTAssertNotNil(result, "Movie Details is nil even if the response is successfully executed")
            XCTAssertEqual(result.originalTitle, movieTitle, "Movie Details is not matching the movie selected (Very Serious issue may be wrong movie id is passed to the API)")
            
            
        }

    }

}
