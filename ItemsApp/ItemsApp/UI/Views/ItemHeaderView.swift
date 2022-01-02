//
//  ItemHeaderView.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import UIKit

public final class ItemHeaderView: UIView {
    public let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .title2)
        view.textColor = UIColor.primaryColor
        return view
    }()
    
    public let subtitleLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .footnote)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.textColor = UIColor.primaryColor
        return view
    }()
    
    public let dateLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .caption1)
        view.textColor = UIColor.secondaryColor
        return view
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    
    private func setup() {
        setupView()
        setupLayout()
    }
    
    private func setupView() {
        backgroundColor = .clear
    }
    
    private func setupLayout() {
        let contentStack = UIStackView.make(axis: .vertical)
        let headerStack = UIStackView.make(axis: .horizontal)
        let spacer = UIView()
        
        contentStack.addArrangedSubview(headerStack)
        contentStack.addArrangedSubview(subtitleLabel)
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(spacer)
        headerStack.addArrangedSubview(dateLabel)
        
        self.addSubview(contentStack)
        
        dateLabel.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        titleLabel.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        contentStack.fill(in: self, margin: 0)
    }
    
    public func configure(title: String, subtitle: String, date: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        dateLabel.text = date
    }
}
