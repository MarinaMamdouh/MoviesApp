//
//  Fonts.swift
//  MoviesApp
//
//  Created by Marina on 14/09/2022.
//

import Foundation
import UIKit

extension UIFont{
    static let theme = FontTheme()
}

// General Font theme
struct FontTheme{
    let largeTitleFont = UIFont.preferredFont(forTextStyle: .largeTitle)
     let subTitleFont = UIFont.systemFont(ofSize: 20)
     let bodyFont = UIFont.systemFont(ofSize: 16)
     let bodyFontBold = UIFont.systemFont(ofSize: 16, weight: .bold)
     let subTitleBoldFont = UIFont.systemFont(ofSize: 20, weight: .bold)
     let smallFont =  UIFont.systemFont(ofSize: 12)
}
