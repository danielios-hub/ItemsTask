//
//  UIStackView+Make.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import UIKit

extension UIStackView {
    static func make(axis: NSLayoutConstraint.Axis, spacing: CGFloat = 8) -> UIStackView {
        let stack = UIStackView()
        stack.axis = axis
        stack.spacing = spacing
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }
}
