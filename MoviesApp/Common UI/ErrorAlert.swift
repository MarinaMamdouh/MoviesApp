//
//  ErrorAlert.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with message: String, action: UIAlertAction) {
        let title = Constants.Texts.errorTitle
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
