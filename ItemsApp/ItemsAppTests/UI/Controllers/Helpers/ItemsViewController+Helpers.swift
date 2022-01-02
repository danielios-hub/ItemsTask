//
//  ItemsViewController+Helpers.swift
// ItemsAppTests
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import Foundation
import ItemsApp

public extension ItemsViewController {
    var isLoading: Bool {
        return self.indicator.isAnimating
    }
    
    var isErrorVisible: Bool {
        return errorView != nil
    }
    
    var numberOfRows: Int {
        return tableView.dataSource?.tableView(tableView, numberOfRowsInSection: itemsSection) ?? 0
    }
    
    func cell(at row: Int, section: Int = 0) -> ItemViewCell {
        let indexPath = IndexPath(row: row, section: section)
        return tableView.dataSource?.tableView(tableView, cellForRowAt: indexPath) as! ItemViewCell
    }
    
    func select(at row: Int, section: Int = 0) {
        let indexPath = IndexPath(row: row, section: section)
        tableView.delegate?.tableView?(tableView, didSelectRowAt: indexPath)
    }
    
    var itemsSection: Int {
        return 0
    }
}
 
public extension ItemViewCell {
    var title: String? {
        return headerView.titleLabel.text
    }
    
    var subtitle: String? {
        return headerView.subtitleLabel.text
    }
    
    var date: String? {
        return headerView.dateLabel.text
    }
}
