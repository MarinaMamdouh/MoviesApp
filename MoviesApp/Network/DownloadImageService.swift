//
//  DownloadImageService.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation
import UIKit

class DownloadImageService {
    
    func requestImage(name: String, size: String) async throws -> UIImage {
        // check if it is in caching
        let api = APIRequest.getImage(name, size)
        let request = api.asRequest()
        let imageFileManager = ImageFileManager(isPngImage: Constants.Files.isImageTypePNG)
        if let image = imageFileManager.getFile(name: name){
            return image
        }
        let session = URLSession.shared
        return try await withCheckedThrowingContinuation { continuation in
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                DispatchQueue.main.async {
                    guard
                        let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                        let data = data,
                        error == nil,
                        let image = UIImage(data: data)
                    else {
                        continuation.resume(with: .failure(RequestError.networkError(url: request.url?.absoluteString ?? "")))
                        return
                        
                    }
                    // Cache the image
                    imageFileManager.save(file: image, fileName: name)
                    continuation.resume(with: .success(image))
                }
            })
            
            task.resume()
        }
    }

}
