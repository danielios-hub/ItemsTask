//
//  ItemsViewModel.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 17/12/21.
//

import Foundation

public struct ItemsViewModel {
    public let items: [ItemViewModel]
    
    public init(items: [ItemViewModel]) {
        self.items = items
    }
}
