//
//  RequestHandler.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation

/// This is RequestHandling implementation returns any Codable Data Model.
class RequestHandler {

    func request<T>(route: APIRequest, completionHandler: @escaping (Result<T, RequestError>) -> Void) where T: Codable {
        let request = route.asRequest()
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            // Request Error
            let httpURLResponse = response as? HTTPURLResponse
            if (error != nil) || (httpURLResponse?.statusCode != 200) {
                let networkError = RequestError.networkError( url: request.url?.absoluteString ?? "")
                completionHandler(.failure(networkError))
                return
            }
            // check if data is not empty
            if let data = data {
                // Try Parsing data
                if let responseResults = self.parse(data: data, to: T.self) {
                    completionHandler(.success(responseResults))
                } else {
                    // Parsing Error
                    completionHandler(.failure(RequestError.jsonParseError(model: "\(T.self)", url: request.url?.absoluteString ?? "")))
                }
            } else {
                // No Data recieved
                let networkError = RequestError.networkError( url: request.url?.absoluteString ?? "")
                completionHandler(.failure(networkError))
            }

        }
        task.resume()

    }

    // Parse any Json data to the given Data Model Type
    private func parse<T>(data: Data, to type: T.Type ) -> T? where T: Codable {
        do {
            let dataObject = try JSONDecoder().decode(type, from: data)
            return dataObject
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
