//
//  ItemsMapper.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 16/12/21.
//

import Foundation

public final class ItemsMapper {
    
    public typealias Result = Swift.Result<[Item], Swift.Error>
    
    private enum Error: Swift.Error {
        case invalidData
    }
    
    private struct Root: Decodable {
        private let items: [LocalItem]
        
        private struct LocalItem: Decodable {
            let id: Int
            let title: String
            let subtitle: String
            let date: Date
        }
        
        var model: [Item] {
            return items.map { return Item(
                id: $0.id,
                title: $0.title,
                subtitle: $0.subtitle,
                body: nil,
                date: $0.date) }
        }
    }
    
    public static func map(_ data: Data, _ response: HTTPURLResponse) -> Result {
        guard response.isOK(),
              let model = try? ItemDecoder<Root>.decode(data).model else {
                  return .failure(Error.invalidData)
              }
        
        return .success(model)
    }
    
}
