//
//  NewsList.swift
//  NewsUITests
//
//  Created by Dheeraj Chahar on 02/02/21.
//

import XCTest

final class NewsList: Screen {
    
    private lazy var newsTableView = app.tables["NewsTableView"]
    
    var newsTableViewExists: Bool {
        return exists(newsTableView, timeout: 32)
    }
    
    var navigationTitleExists: Bool {
        return exists(app.staticTexts["News"], timeout: 32)
    }
    
    var newsTitleExists: Bool {
        return exists(newsTableView.staticTexts["News Title 4"], timeout: 32)
    }
    
    var newsDescriptionExists: Bool {
        return exists(newsTableView.staticTexts["News Description 4"], timeout: 32)
    }
    
    var scrollNewsTitleExists: Bool {
        return exists(newsTableView.staticTexts["News Title 14"], timeout: 32)
    }
    
    var scrollNewsDescriptionExists: Bool {
        return exists(newsTableView.staticTexts["News Description 14"], timeout: 32)
    }
    
    func scrollTo(_ newsTitle: String) {
        app.scrollTo(element: newsTableView.staticTexts[newsTitle])
    }
    
    func refreshNews() {
        app.staticTexts["News Title 4"].tap()

        let firstCell = app.staticTexts["News Title 4"]
        let coordinate = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let bottom = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 20))
        coordinate.press(forDuration: 0, thenDragTo: bottom)
    }
}
