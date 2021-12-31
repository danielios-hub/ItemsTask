//
//  ItemsPresenter.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 17/12/21.
//

import Foundation

public final class ItemsPresenter {
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    static public func map(_ items: [Item]) -> ItemsViewModel {
        return ItemsViewModel(items: items.map {
            .init(
                id: $0.id,
                title: $0.title,
                subtitle: $0.subtitle,
                date: formatter.string(from: $0.date))
        })
    }
}
