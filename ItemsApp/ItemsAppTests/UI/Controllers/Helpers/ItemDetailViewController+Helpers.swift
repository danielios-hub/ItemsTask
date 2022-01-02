//
//  ItemDetailViewController+Helpers.swift
// ItemsAppTests
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import UIKit
import ItemsApp

public extension ItemDetailViewController {
    var isLoading: Bool {
        return self.indicator.isAnimating
    }
    
    var isErrorVisible: Bool {
        return errorView != nil
    }
    
    var numberOfRows: Int {
        return tableView.dataSource?.tableView(tableView, numberOfRowsInSection: itemsSection) ?? 0
    }
    
    func cell(at row: Int, section: Int = 0) -> ItemDetailViewCell {
        let indexPath = IndexPath(row: row, section: section)
        return tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as! ItemDetailViewCell
    }
    
    var itemsSection: Int {
        return 0
    }
}

public extension ItemDetailViewCell {
    var title: String? {
        return headerView.titleLabel.text
    }
    
    var subtitle: String? {
        return headerView.subtitleLabel.text
    }
    
    var date: String? {
        return headerView.dateLabel.text
    }
    
    var body: String? {
        return bodyLabel.text
    }
}
