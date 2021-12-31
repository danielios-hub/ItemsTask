//
//  ItemDetailViewModel.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import Foundation

public struct ItemDetailViewModel: Equatable {
    public let title: String
    public let subtitle: String
    public let date: String
    public let body: String?
    
    public init(title: String, subtitle: String, date: String, body: String?) {
        self.title = title
        self.subtitle = subtitle
        self.date = date
        self.body = body
    }
}
