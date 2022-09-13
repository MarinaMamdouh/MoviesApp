//
//  RequestError.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation

enum RequestError: LocalizedError{
    case networkError(url: String)
    case jsonParseError(model: String, url: String)
    case unknownError
    
    var errorDescription: String?{
        switch self {
        case .networkError(let url):
            return "[⚠️] Bad response from the API URL: \(url)"
        case .jsonParseError(let modelName, let url):
            return "[⚠️] Error while parsing response data from API url \(url) to model: \(modelName)"
        case .unknownError:
            return "[⚠️] unknow error occurred"
        }
    }
}
