//
//  DownloadImageService.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation
import UIKit

class DownloadImageService {
    
    func requestImage(name: String, size: String, completionHandler: @escaping (Result<UIImage, RequestError>) -> Void) {
        // check if it is in caching
        let api = APIRequest.getImage(name, size)
        let request = api.asRequest()
        let imageFileManager = ImageFileManager(isPngImage: Constants.Files.isImageTypePNG)
        if let image = imageFileManager.getFile(name: name){
            completionHandler(.success(image))
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let data = data,
                    error == nil,
                    let image = UIImage(data: data)
                else {
                    completionHandler(.failure(RequestError.networkError(url: request.url?.absoluteString ?? "")))
                    return
                }
                
                // Cache the image
                imageFileManager.save(file: image, fileName: name)
                completionHandler(.success(image))
            }
        }
        task.resume()
    }

}
