//
//  NewsService.swift
//  News
//
//  Created by Dheeraj Chahar on 01/02/21.
//

import Foundation

/// Handles news service request
protocol NewsAPIServiceProtocol: AnyObject {
    func getNews(completion: @escaping (Result<[News], APIError>) -> Void)
}

class NewsService: NewsAPIServiceProtocol {
    
    /// To get news from server
    /// - Parameter completion: Completion handler of the network call
    func getNews(completion: @escaping (Result<[News], APIError>) -> Void) {
        DispatchQueue.global().async {
            guard let url = Bundle.main.url(forResource: "NewsData", withExtension: "json") else {
                return completion(.failure(.fileNotFound))
            }
            
            sleep(1)
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                do {
                    let jsonData = try decoder.decode([News].self, from: data)
                    completion(.success(jsonData))
                } catch {
                    completion(.failure(.decodingError))
                }
            } catch {
                completion(.failure(.fileCouldNotOpen))
            }
        }
    }
    
}
