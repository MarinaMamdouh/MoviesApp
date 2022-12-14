//
//  APIRequest.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation

/// Enum that encodes the endpoints of the Movies-api. Injected to the RequestHandler.
enum APIRequest {
    case getTrendingMovies(_ page: Int)
    case getMovieDetails(_ id: Int)
    case getImage(_ path: String, _ size: String)
    
    private var url: URL? {
        switch self {
        case .getTrendingMovies(_):
            return URL(string: Constants.APIs.trendingMoviesEndPoint)
        case .getImage(let path, let size):
            var urlString = Constants.APIs.downloadImageEndPoint
            urlString += "/\(size)"
            urlString += "/\(path)"
            return URL(string: urlString)
        case .getMovieDetails(let id):
            var urlString = Constants.APIs.baseMoviesEndPoint
            urlString += "/\(id)"
            return URL(string: urlString)
        }
    }
    
    
    private var parameters: [URLQueryItem] {
        // common Parameters like APIKey, language
        var predifinedParams = [
            Constants.APIs.apiKeyParameter,
            Constants.APIs.moviesLanguageParameter
        ]
        
        switch self {
            
        case .getTrendingMovies(let page):
            predifinedParams.append(Constants.APIs.moviesRegionParameter)
            predifinedParams.append(
                URLQueryItem(name: Constants.APIs.pageParameterKey, value: String(page))
            )
            return predifinedParams
        case .getImage(_,_):
            // image endpoint doesn't take request parameters
            return []
        case .getMovieDetails(_):
            return predifinedParams
        }
    }
    
    func asRequest() -> URLRequest {
        guard let url = url else {
            preconditionFailure("Missing URL for route: \(self)")
        }
        // add parameters(if any) to the URLRequest object
        if !parameters.isEmpty{
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = parameters
            
            guard let parametrizedURL = components?.url else {
                preconditionFailure("Missing URL with parameters for url: \(url)")
            }
            return URLRequest(url: parametrizedURL)
        }
        
        return URLRequest(url: url)
        
    }
}
