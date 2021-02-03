//
//  MockNewsService.swift
//  NewsTests
//
//  Created by Dheeraj Chahar on 01/02/21.
//

import Foundation

@testable import News

class MockNewsService: NewsAPIServiceProtocol {
    
    private var shouldReturnSuccess: Bool
    
    init(shouldReturnSuccess: Bool) {
        self.shouldReturnSuccess = shouldReturnSuccess
    }
    
    func getNews(completion: @escaping (Result<[News], APIError>) -> Void) {
        if shouldReturnSuccess {
            completion(.success([News(newsTitle: "News Title 1", newsDescription: "News Description 1"),
                                 News(newsTitle: "News Title 2", newsDescription: "News Description 2")]))
        } else {
            completion(.failure(.decodingError))
        }
    }
    
}
