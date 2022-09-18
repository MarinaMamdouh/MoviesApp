//
//  MoviesListViewModel.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation

protocol MoviesListDelegate: AnyObject{
    
    func moviesListDidUpdate()
    func showError(message: String)
    func showMovieDetails(details: MovieDetailsModel)
    
}

final class MoviesListPresenter {
    private var currentPage = 0
    private var requestHandler = RequestHandler()
    public var isLoading = false
    public var moviesAreReLoading = false
    var moviesCount: Int {
        self.movies.count
    }
    private(set) var movies = [MovieModel]()
    weak var delegate: MoviesListDelegate?
    
    func loadMovies() {
        self.goToNextPage()
        changeLoadingStatus()
        
        let moviesAPI = APIRequest.getTrendingMovies(currentPage)
        requestHandler.request(route: moviesAPI) { [weak self] (result: Result<MoviesResponse,RequestError>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    // if movies array before appending is empty
                    // then moviesAre loading for the first time
                    // else movies are reloading
                    self.moviesAreReLoading = !self.movies.isEmpty
                    self.movies.append(contentsOf: response.results)
                    self.delegate?.moviesListDidUpdate()
                case .failure(_):
                    // update View with Error
                    self.delegate?.showError(message: Constants.Texts.networkConnectionErrorMessage)
                    break
                }
                self.changeLoadingStatus()
            }
        }
    }
    
    func getDetails(of movieIndex: Int){
        let selectedMovie = self.movies[movieIndex]
        guard let id = selectedMovie.id else {
            // API returns nil id
            delegate?.showError(message: "There is an error")
            return
        }
        let detailsAPI = APIRequest.getMovieDetails(id)
        requestHandler.request(route: detailsAPI) { [weak self] (result: Result<MovieDetailsModel,RequestError>) in
            DispatchQueue.main.async {
                switch result{
                case .success(let response):
                    self?.delegate?.showMovieDetails(details: response)
                case .failure(_):
                    self?.delegate?.showError(message: "There is an error")
                    break
                }
            }
        }
    }
    
    func displayedAllMovies() -> Bool{
        // if presenter is not currently loading
        if !isLoading{
            loadMovies()
            return true
        }
        return false
    }
    
    private func goToNextPage() {
        currentPage += 1
    }
    
    private func changeLoadingStatus() {
        self.isLoading.toggle()
    }
}
