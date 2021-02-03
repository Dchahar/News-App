//
//  NewsDataRepository.swift
//  News
//
//  Created by Dheeraj Chahar on 01/02/21.
//

import UIKit

class NewsDataRepository: NewsRepositoryProtocol {
    
    // MARK: - Properties
    
    var news = [News]() {
        didSet {
            self.didReceiveNews?()
        }
    }
    
    var updateLoadingStatus: (()->())?
    var didReceiveNews: (() -> ())?
    var didFailReceiveNews: ((String) -> ())?
    var numberOfPagination = 10
    var apiService: NewsAPIServiceProtocol
    
    init(apiService: NewsAPIServiceProtocol) {
        self.apiService = apiService
    }
    
    /// To notify the data is loading
    var isLoading: Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }
    
    /// To get top news from the service
    func getNews() {
        self.isLoading = true
        apiService.getNews { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let news):
                self.news = news
            case .failure(let error):
                self.didFailReceiveNews?(error.rawValue)
            }
            self.isLoading = false
        }
    }
    
    /// To get more news from the service
    func loadMoreNews() {
        if !self.isLoading {
            self.isLoading = true
            let start = news.count
            let end = start + numberOfPagination
            DispatchQueue.global().async {
                sleep(2)
                for i in start...end {
                    self.news.append(News(newsTitle: "News Title \(i)", newsDescription: "News Description \(i)"))
                }
                self.isLoading = false
            }
        }
    }
    
    /// Available number of news to show
    func numberOfRows() -> Int {
        return self.news.count
    }
    
    /// To show news in each cell
    func cellForRowAt(indexPath: IndexPath, for cell: NewsTableViewCell) -> NewsTableViewCell {
        let news = self.news[indexPath.row]
        cell.setup(newsTitle: news.newsTitle, newsDescription: news.newsDescription)
        return cell
    }
    
}
