//
//  UITableViewCell+Helpers.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import UIKit

extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
