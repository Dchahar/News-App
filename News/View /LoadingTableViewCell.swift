//
//  LoadingTableViewCell.swift
//  News
//
//  Created by Dheeraj Chahar on 02/02/21.
//

import UIKit

class LoadingTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    lazy fileprivate(set) var activityIndicator: UIActivityIndicatorView = {
        let actIndicator = UIActivityIndicatorView(frame: .zero)
        actIndicator.style = .medium
        return actIndicator
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
}

// MARK: - Private Methods

private extension LoadingTableViewCell {
    
    func setupContraints() {
        self.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

}
