//
//  Money.swift
//  MoviesApp
//
//  Created by Marina on 14/09/2022.
//

import Foundation

extension Int {
    var toMoney: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale =  Locale(identifier: "en")
        formatter.currencySymbol = "$"
        formatter.maximumFractionDigits = 0
        if let formattedAmount = formatter.string(from: self as NSNumber) {
            return formattedAmount
        }
        return ""
    }
}
