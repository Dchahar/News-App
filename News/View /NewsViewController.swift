//
//  ViewController.swift
//  News
//
//  Created by Dheeraj Chahar on 01/02/21.
//

import UIKit
import SnapKit

class NewsViewController: UIViewController {
    
    // MARK: - Properties
    
    lazy var newsTableView : UITableView = {
        let tbv = UITableView(frame: .zero, style: .grouped)
        return tbv
    }()
    
    lazy fileprivate(set) var refreshControl: UIRefreshControl = {
        let refControl = UIRefreshControl(frame: .zero)
        refControl.addTarget(self, action: #selector(reloadNews), for: .valueChanged)
        return refControl
    }()
    
    var newsDataRepository: NewsDataRepository! {
        didSet {
            newsDataRepository.didReceiveNews = { [unowned self] in
                DispatchQueue.main.async {
                    self.newsTableView.reloadData()
                }
            }
            
            newsDataRepository.updateLoadingStatus = { [unowned self] in
                DispatchQueue.main.async {
                    let isLoading = self.newsDataRepository.isLoading
                    if isLoading {
                        UIView.animate(withDuration: 0.3, animations: {
                            self.refreshControl.endRefreshing()
                        })
                    } else {
                        UIView.animate(withDuration: 0.3, animations: {
                            self.refreshControl.endRefreshing()
                        })
                    }
                }
            }
            
            newsDataRepository.didFailReceiveNews = { [unowned self] error in
                DispatchQueue.main.async {
                    self.showAlert(message: error)
                }
            }
        }
    }
    
    lazy var viewModel: NewsViewModel = {
        return NewsViewModel(delegate: newsDataRepository)
    }()
    
    // MARK: - Life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "News"
        newsDataRepository = NewsDataRepository(apiService: NewsService())
        newsTableView.delegate = viewModel
        newsTableView.dataSource = viewModel
        newsTableView.refreshControl = refreshControl
        registerCells()
        setupViewConstraints()
        newsDataRepository.getNews()
        setupAccessibilityLabel()
    }
}

// MARK: - Private Methods

private extension NewsViewController {
    
    @objc private func reloadNews() {
        newsDataRepository.getNews()
    }
    
    func registerCells() {
        newsTableView.register(NewsTableViewCell.self, forCellReuseIdentifier: "newsCell")
        newsTableView.register(LoadingTableViewCell.self, forCellReuseIdentifier: "loadingCell")
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "News", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { (_) in }))
        present(alert, animated: true, completion: {})
    }
    
    func setupViewConstraints() {
        self.view.addSubview(newsTableView)
        newsTableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func setupAccessibilityLabel() {
        newsTableView.accessibilityLabel = "NewsTableView"
    }
    
}
