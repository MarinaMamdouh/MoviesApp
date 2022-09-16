//
//  UIViewController.swift
//  MoviesApp
//
//  Created by Marina on 16/09/2022.
//

import UIKit

extension UIViewController {
    func styleNavigationMultilineTitle() {
        // get the navigation bar of the ViewController
        if let titleView = navigationItem.titleView{
            for view in titleView.subviews {
                guard let label = view as? UILabel else { break }
                if label.text == self.title {
                    label.numberOfLines = 0
                    label.lineBreakMode = .byWordWrapping
                }
            }
        }
    }
}
