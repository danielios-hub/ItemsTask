//
//  ItemDetailMapper.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 16/12/21.
//

import Foundation

public final class ItemDetailMapper {
    
    public typealias Result = Swift.Result<Item, Swift.Error>
    
    private enum Error: Swift.Error {
        case invalidData
    }
    
    private struct Root: Decodable {
        private let item: LocalItem
        
        private struct LocalItem: Decodable {
            let id: Int
            let title: String
            let subtitle: String
            let body: String?
            let date: Date
        }
        
        var model: Item {
            return Item(
                id: item.id,
                title: item.title,
                subtitle: item.subtitle,
                body: item.body,
                date: item.date)
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
