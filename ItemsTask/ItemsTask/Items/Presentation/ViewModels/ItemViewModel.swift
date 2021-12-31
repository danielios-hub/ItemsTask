//
//  ItemViewModel.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 17/12/21.
//

import Foundation

public struct ItemViewModel: Equatable {
    public let id: Int
    public let title: String
    public let subtitle: String
    public let date: String
    
    public init(id: Int, title: String, subtitle: String, date: String) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.date = date
    }
}
