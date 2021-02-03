//
//  XCUITestCase.swift
//  NewsUITests
//
//  Created by Dheeraj Chahar on 02/02/21.
//

import XCTest

class XCUITestCase: XCTestCase {
    
    var hybridUpgradeEnabled = false
    
    internal var newsApp: Screen!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
    }
    
    override func tearDown() {
        if super.testRun!.failureCount > 0 {
            takeScreenshotOf(testCase: super.testRun!.test.debugDescription)
        }
        super.tearDown()
    }
}

extension XCUITestCase {
    
    func given(_ text: String, step: () -> Void ) {
        step()
        newsApp = TestBuilder.resetAndlaunch()
        XCTContext.runActivity(named: "Given " + text) { _ in }
    }
    
    func when(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: "When " + text) { _ in
            step()
        }
    }
    
    func then(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: "Then " + text) { _ in
            step()
        }
    }
    
    func and(_ text: String, step: () -> Void ) {
        XCTContext.runActivity(named: "And " + text) { _ in
            step()
        }
    }
}
