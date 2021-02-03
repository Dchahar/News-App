//
//  NewsViewControllerSpec.swift
//  NewsUITests
//
//  Created by Dheeraj Chahar on 02/02/21.
//

import XCTest

class NewsViewControllerSpec: XCUITestCase {
    
    func testLoadNews() {

        given("News app installed on the device") {}
        when("I launch news app") {}
        and("I wait for loading news") {}
        then("I should see the nav bar and table view with news title and description") {
            XCTAssertTrue(newsApp.on(screen: NewsList.self).navigationTitleExists, "Unable to see nav bar title")
            XCTAssertTrue(newsApp.on(screen: NewsList.self).newsTableViewExists, "Unable to see table view")
            XCTAssertTrue(newsApp.on(screen: NewsList.self).newsTitleExists, "Unable to see news title")
            XCTAssertTrue(newsApp.on(screen: NewsList.self).newsDescriptionExists, "Unable to see news description")
        }
    }
    
    func testNewsList() {

        given("News loaded into the table view") {}
        when("I scroll news items") {
            newsApp.on(screen: NewsList.self).scrollTo("")
        }
        and("I wait for scrolling") {}
        then("I should see the news title and description") {
            XCTAssertTrue(newsApp.on(screen: NewsList.self).scrollNewsTitleExists, "Unable to see news title")
            XCTAssertTrue(newsApp.on(screen: NewsList.self).scrollNewsDescriptionExists, "Unable to see news description")
        }
    }
    
    func testRefreshControl() {
        
        given("News loaded into the table view") {}
        when("I reload news items") {
            newsApp.on(screen: NewsList.self).refreshNews()
        }
        and("I wait for reload") {}
        then("I should see the news title and description") {
            XCTAssertTrue(newsApp.on(screen: NewsList.self).newsTitleExists, "Unable to see news title")
            XCTAssertTrue(newsApp.on(screen: NewsList.self).newsDescriptionExists, "Unable to see news description")
        }
        
    }
}
