//
//  ItemMapper.swift
//  SomeCompanyTaskTests
//
//  Created by Daniel Gallego Peralta on 16/12/21.
//

import XCTest
import ItemsTask

class ItemDetailMapperTests: XCTestCase {

    func test_map_withInvalidDataAndNon2xxResponse_returnFailure() {
        for code in invalidCodes() {
            let response = HTTPURLResponse(url: anyURL(), statusCode: code, httpVersion: nil, headerFields: [:])!
            let result = ItemDetailMapper.map(invalidData(), response)
            assertResult(
                receivedResult: result,
                expectedResult: .failure(anyNSError()))
        }
    }
    
    func test_map_withInvalidDataAnd2xxResponse_returnFailure() {
        for code in validCodes() {
            let response = HTTPURLResponse(url: anyURL(), statusCode: code, httpVersion: nil, headerFields: [:])!
            let result = ItemDetailMapper.map(invalidData(), response)
            assertResult(
                receivedResult: result,
                expectedResult: .failure(anyNSError()))
        }
    }
    
    func test_map_withValidDataAnd2xxResponse_returnSuccessWithItems() {
        let (item, data) = makeItems()
        for code in validCodes() {
            let response = HTTPURLResponse(url: anyURL(), statusCode: code, httpVersion: nil, headerFields: [:])!
            let result = ItemDetailMapper.map(data, response)
            assertResult(
                receivedResult: result,
                expectedResult: .success(item.model))
        }
    }
    
    func test_map_withValidDataAndNon2xxResponse_returnFailure() {
        let (_, data) = makeItems()
        for code in invalidCodes() {
            let response = HTTPURLResponse(url: anyURL(), statusCode: code, httpVersion: nil, headerFields: [:])!
            let result = ItemDetailMapper.map(data, response)
            assertResult(
                receivedResult: result,
                expectedResult: .failure(anyNSError()))
        }
    }
    
    private func assertResult(receivedResult: ItemDetailMapper.Result, expectedResult: ItemDetailMapper.Result, file: StaticString = #file, line: UInt = #line) {
        switch (receivedResult, expectedResult) {
        case (.failure, .failure): break
        case let (.success(receiveItems), .success(expectedItems)):
            XCTAssertEqual(receiveItems, expectedItems, file: file, line: line)
        default: XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
        }
    }
    
    //MARK: - Helpers
    
    private func makeItems() -> (item: (model: Item, json: [String : Any]), data: Data) {
        let dateInfo1: (String, TimeInterval) = (string: "28/08/2020 15:07", timeinterval: 1598627220)
    
        let item = makeItem(
            id: 36,
            title: "a title",
            subtitle: "a subtitle",
            body: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi",
            dateInfo: dateInfo1)
        let data = makeItemsJSON(item.json)
        
        return (item, data)
    }
    
    private func makeItemsJSON(_ item: [String: Any]) -> Data {
        let json = ["item": item]
        return try! JSONSerialization.data(withJSONObject: json)
    }

}
