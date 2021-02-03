//
//  TestBuilder.swift
//  NewsUITests
//
//  Created by Dheeraj Chahar on 02/02/21.
//

import XCTest

final class TestBuilder {
    
    static func resetAndlaunch() -> Screen {
        let app = XCUIApplication()
        app.launchArguments = ["-UITests"]
        app.launch()
        return Screen(app)
    }
}
