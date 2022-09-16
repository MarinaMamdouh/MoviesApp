//
//  Colors.swift
//  MoviesApp
//
//  Created by Marina on 16/09/2022.
//

import Foundation
import UIKit

extension UIColor{
    static let theme = ColorTheme()
}

// General Font theme
struct ColorTheme{
    let background = UIColor(named: "Background")!
    let primary = UIColor(named: "Primary")!
    let secondary = UIColor(named: "Secondary")!
}
