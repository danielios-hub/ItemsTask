//
//  ItemEndpoints.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import Foundation

public enum ItemEndpoint {
    case getAll
    case get(Int)
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case .getAll: return baseURL.appendingPathComponent("items/contentList.json")
        case let .get(id): return baseURL.appendingPathComponent("items/content/\(id).json")
        }
    }
}
