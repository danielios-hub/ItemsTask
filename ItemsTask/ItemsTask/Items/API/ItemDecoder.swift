//
//  ItemDecoder.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 16/12/21.
//

import Foundation

struct ItemDecoder<ItemType: Decodable> {
    
    public static func decode(_ data: Data) throws -> ItemType {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        let root = try decoder.decode(ItemType.self, from: data)
        return root
    }

}
