//
//  Date.swift
//  MoviesApp
//
//  Created by Marina on 16/09/2022.
//

import Foundation

extension Date {
    // get any component in Date e.g. year, month , day ,...etc
    func get(_ datePart: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
            return calendar.component(datePart, from: self)
    }
}
