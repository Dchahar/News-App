//
//  NewsTableViewCell.swift
//  News
//
//  Created by Dheeraj Chahar on 01/02/21.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy var newsTitle: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    lazy var newsDescription: UILabel = {
        let lbl = UILabel(frame: .zero)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    // MARK: - Constructor
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupContraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: - Config Methods
    
    func setup(newsTitle: String, newsDescription: String){
        self.newsTitle.text = newsTitle
        self.newsDescription.text = newsDescription
    }
    
}

// MARK: - Private Methods

private extension NewsTableViewCell {
    
    func setupContraints() {
        self.addSubview(newsTitle)
        self.addSubview(newsDescription)
        
        newsTitle.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(16)
            make.bottom.equalTo(newsDescription.snp.top).offset(-16)
        }
        
        newsDescription.snp.makeConstraints { (make) in
            make.left.right.equalTo(16)
            make.bottom.equalTo(-16)
        }
    }

}
