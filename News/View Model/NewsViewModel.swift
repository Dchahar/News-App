//
//  NewsViewModel.swift
//  News
//
//  Created by Dheeraj Chahar on 01/02/21.
//

import UIKit

class NewsViewModel: NSObject {
    
    // MARK: - Properties
    
    var delegate: NewsRepositoryProtocol
    
    // MARK: - Constructor
    
    init(delegate: NewsRepositoryProtocol) {
        self.delegate = delegate
    }
}

// MARK: - UITableViewDataSource

extension NewsViewModel: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return delegate.numberOfRows()
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell else { fatalError("Misconfigured news cell")
            }
            return delegate.cellForRowAt(indexPath: indexPath, for: cell)
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as? LoadingTableViewCell else { fatalError("Misconfigured loading cell")
            }
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
}

// MARK: - UITableViewDelegate

extension NewsViewModel: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if (indexPath.item + 1 == delegate.numberOfRows()) {
            delegate.loadMoreNews()
        }
    }
    
}
