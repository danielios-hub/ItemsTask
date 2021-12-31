//
//  Item.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 16/12/21.
//

import Foundation

public struct Item: Equatable {
    let id: Int
    public let title: String
    public let subtitle: String
    let body: String?
    public let date: Date
    
    public init(id: Int, title: String, subtitle: String, body: String?, date: Date) {
        self.id = id
        self.title = title
        self.subtitle = subtitle
        self.body = body
        self.date = date
    }
}
