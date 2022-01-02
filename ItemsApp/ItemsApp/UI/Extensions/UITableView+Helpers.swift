//
//  UITableView+Helpers.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import UIKit

extension UITableView {
    func register<CellType: UITableViewCell>(cellType type: CellType.Type) {
        self.register(type, forCellReuseIdentifier: CellType.reuseIdentifier)
    }
    
    func dequeueCell<CellType>() -> CellType {
        return self.dequeueReusableCell(withIdentifier: String(describing: CellType.self)) as! CellType
    }
}
