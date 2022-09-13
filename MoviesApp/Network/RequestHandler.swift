//
//  RequestHandler.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation

/// This is RequestHandling implementation returns any Codable Data Model.
class RequestHandler {

    func request<T>(route: APIRequest) async throws -> T where T: Codable {
        let request = route.asRequest()
        let session = URLSession.shared
        return try await withCheckedThrowingContinuation { continuation in
            let task = session.dataTask(with: request, completionHandler: { data, _, error -> Void in
                // Request Error
                if let _ = error {
                    let networkError = RequestError.networkError( url: request.url?.absoluteString ?? "")
                    continuation.resume(with: .failure(networkError))
                    return
                }
                // check if data is not empty
                if let data = data {
                    // Try Parsing data
                    if let responseResults = self.parse(data: data, to: T.self) {
                        continuation.resume(with: .success(responseResults))
                    } else {
                        // Parsing Error
                        continuation.resume(with: .failure(RequestError.jsonParseError(model: "\(T.self)", url: request.url?.absoluteString ?? "")))
                    }
                } else {
                    // No Data recieved
                    let networkError = RequestError.networkError( url: request.url?.absoluteString ?? "")
                    continuation.resume(with: .failure(networkError))
                }
            })

            task.resume()
        }
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
