//
//  NewsViewControllerSpec.swift
//  NewsTests
//
//  Created by Dheeraj Chahar on 01/02/21.
//

import XCTest

@testable import News

class NewsViewControllerSpec: XCTestCase {
    
    var subject: NewsViewController?
    
    override func setUp() {
        subject = NewsViewController(nibName: nil, bundle: nil)
    }
    
    func testNewsViewController_LoadingNews_shouldDisplayNewsList() {
        let mockNewsService = MockNewsService(shouldReturnSuccess: true)
        subject?.newsDataRepository = NewsDataRepository(apiService: mockNewsService)
        mockNewsService.getNews { response in
            switch response {
            case .success(let news):
                self.subject?.newsDataRepository.news = news
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        let lastRow = subject!.newsDataRepository.news.count - 1
        let indexPath = IndexPath(row: lastRow, section: 0)
        let cell = NewsTableViewCell(style: NewsTableViewCell.CellStyle.default, reuseIdentifier: "newsCell")
        let newsCell = subject?.viewModel.delegate.cellForRowAt(indexPath: indexPath, for: cell)
        
        sleep(1)
        XCTAssertTrue(newsCell != nil)
        XCTAssertTrue(subject?.newsDataRepository.numberOfRows() == subject?.newsDataRepository.news.count)
        XCTAssertTrue(newsCell?.newsTitle.text == subject?.newsDataRepository.news[lastRow].newsTitle)
    }
    
    func testNewsViewController_LoadingNews_shouldDisplayDecodingError() {
        let mockNewsService = MockNewsService(shouldReturnSuccess: false)
        subject?.newsDataRepository = NewsDataRepository(apiService: mockNewsService)
        var result: Any?
        
        mockNewsService.getNews { response in
            switch response {
            case .success(let news):
                result = news
                self.subject?.newsDataRepository.news = news
            case .failure(let error):
                result = error
                self.subject?.newsDataRepository.didFailReceiveNews?(APIError.decodingError.rawValue)
                XCTAssertTrue(error == APIError.decodingError)
            }
        }
        
        XCTAssertFalse(result is [News])
        XCTAssertTrue(result is APIError)
    }

}
