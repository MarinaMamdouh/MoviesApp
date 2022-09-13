//
//  ErrorAlert.swift
//  MoviesApp
//
//  Created by Marina on 13/09/2022.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(with message: String) {
        let title = "Error"
        let okButtonTitle = "Ok"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: okButtonTitle, style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}