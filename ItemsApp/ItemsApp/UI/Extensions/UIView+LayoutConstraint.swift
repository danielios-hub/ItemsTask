//
//  UIView+LayoutConstraint.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import UIKit

extension UIView {
    func center(in containerView: UIView) {
        NSLayoutConstraint.activate([
            centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    func fill(in containerView: UIView, margin: CGFloat = 8) {
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: margin),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: margin),
            topAnchor.constraint(equalTo: containerView.topAnchor, constant: margin),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: margin)
        ])
    }
    
    func fillInSafeArea(in containerView: UIView, margin: CGFloat = 8) {
        let layoutGuide = containerView.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor, constant: margin),
            layoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: margin),
            topAnchor.constraint(equalTo: layoutGuide.topAnchor, constant: margin),
            layoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: margin)
        ])
    }
}
