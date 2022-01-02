//
//  ErrorView.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import UIKit

public final class ErrorView: UIView {
    
    private let message: String
    
    private let errorLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textAlignment = .center
        view.textColor = .white
        view.font = .preferredFont(forTextStyle: .body)
        return view
    }()
    
    public init(message: String, frame: CGRect) {
        self.message = message
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        backgroundColor = UIColor.errorColor
        errorLabel.text = message
        
        addSubview(errorLabel)
        errorLabel.fill(in: self)
    }
}
