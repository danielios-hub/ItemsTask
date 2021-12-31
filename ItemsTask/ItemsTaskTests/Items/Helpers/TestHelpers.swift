//
//  TestHelpers.swift
//  SomeCompanyTaskTests
//
//  Created by Daniel Gallego Peralta on 17/12/21.
//

import Foundation
import ItemsTask

func makeItems() -> (items: [(model: Item, json: [String : Any])], data: Data){
    let dateInfo1: (String, TimeInterval) = (string: "28/08/2020 15:07", timeinterval: 1598627220)
    let dateInfo2: (String, TimeInterval) = (string: "01/11/2021 12:49", timeinterval: 1635770940)

    let item1 = makeItem(id: 0, title: "a title", subtitle: "a subtitle", dateInfo: dateInfo1)
    let item2 = makeItem(id: 1, title: "another title", subtitle: "another subtitle", dateInfo: dateInfo2)
    let items = [item1, item2]
    let data = makeItemsJSON([item1.json, item2.json])
    
    return (items, data)
}

func makeItem(
    id: Int,
    title: String,
    subtitle: String,
    body: String? = nil,
    dateInfo: (date: String, timestamp: TimeInterval)
) -> (model: Item, json: [String: Any]) {
    let date = Date(timeIntervalSince1970: dateInfo.timestamp)
    let item = Item(id: id, title: title, subtitle: subtitle, body: body, date: date)
    var json: [String: Any] = [
        "id": id,
        "title": title,
        "subtitle": subtitle,
        "date": dateInfo.date
    ]
    
    if let body = body {
        json["body"] = body
    }
        
    return (item, json)
}

func makeItemsJSON(_ items: [[String: Any]]) -> Data {
    let json = ["items": items]
    return try! JSONSerialization.data(withJSONObject: json)
}

func anyNSError() -> Error {
    return NSError()
}

func anyData() -> Data {
    return Data("Any String".utf8)
}

func anyURL() -> URL {
    return URL(string: "http://any-url.com")!
}

func invalidData() -> Data {
    return Data()
}

func invalidCodes() -> [Int] {
    return [150, 199, 300, 350, 400, 500]
}

func validCodes() -> [Int] {
    return [200, 201, 210, 250, 280, 299]
}
