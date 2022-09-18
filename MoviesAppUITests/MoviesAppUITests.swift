//
//  MoviesAppUITests.swift
//  MoviesAppUITests
//
//  Created by Marina on 13/09/2022.
//

import XCTest

class MoviesAppUITests: XCTestCase {

    func testLaunchPerformance() throws {
    if #available(iOS 15.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
