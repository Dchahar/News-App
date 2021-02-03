//
//  NewsRepositoryProtocol.swift
//  News
//
//  Created by Dheeraj Chahar on 01/02/21.
//

import UIKit

/// Protocol for news repository
protocol NewsRepositoryProtocol {
    
    /// All available news
    var news: [News] { get set }
    
    /// To get top news from the service
    func getNews()
    
    /// To get more news from the service
    func loadMoreNews()
    
    /// Available number of news to show
    func numberOfRows() -> Int
    
    /// To show news in each cell
    func cellForRowAt(indexPath: IndexPath, for cell: NewsTableViewCell) -> NewsTableViewCell
    
}
