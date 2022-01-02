//
//  ItemViewCell.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import UIKit
import ItemsTask

public final class ItemViewCell: UITableViewCell {

    public let headerView: ItemHeaderView = {
        let view = ItemHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor.secondaryBackground
        return view
    }()
    
    //MARK: - Life cicle
    
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    override public func awakeFromNib() {
        super.awakeFromNib()
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
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    private func setupLayout() {
        let contentStack = UIStackView.make(axis: .vertical)

        contentStack.addArrangedSubview(headerView)
        containerView.addSubview(contentStack)
        contentView.addSubview(containerView)

        containerView.fill(in: contentView)
        contentStack.fill(in: containerView)
    }
    
    public func configure(with model: ItemViewModel) {
        headerView.configure(title: model.title, subtitle: model.subtitle, date: model.date)
    }
}
