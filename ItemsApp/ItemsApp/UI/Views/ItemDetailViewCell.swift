//
//  ItemDetailViewCell.swift
// ItemsApp
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import UIKit
import ItemsTask

public final class ItemDetailViewCell: UITableViewCell {

    public let bodyLabel: UILabel = {
        let view = UILabel()
        view.font = .preferredFont(forTextStyle: .body)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.textColor = UIColor.primaryColor
        return view
    }()
    
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
        contentStack.addArrangedSubview(bodyLabel)

        containerView.addSubview(contentStack)
        contentView.addSubview(containerView)

        containerView.fill(in: contentView)
        contentStack.fill(in: containerView)
    }

    public func configure(with model: ItemDetailViewModel) {
        headerView.configure(title: model.title, subtitle: model.subtitle, date: model.date)
        bodyLabel.text = model.body
    }
}
