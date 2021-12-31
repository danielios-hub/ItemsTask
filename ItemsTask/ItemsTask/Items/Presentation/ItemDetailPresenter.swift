//
//  ItemDetailPresenter.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import Foundation

public final class ItemDetailPresenter {
    
    static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    static public func map(_ item: Item) -> ItemDetailViewModel {
        return ItemDetailViewModel(
            title: item.title,
            subtitle: item.subtitle,
            date: formatter.string(from: item.date),
            body: item.body)
    }
}
