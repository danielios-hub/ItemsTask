//
//  ItemsMapperTests.swift
//  SomeCompanyTaskTests
//
//  Created by Daniel Gallego Peralta on 16/12/21.
//

import XCTest
import ItemsTask

class ItemsMapperTests: XCTestCase {

    func test_map_withInvalidDataAndNon2xxResponse_returnFailure() {
        for code in invalidCodes() {
            let response = HTTPURLResponse(url: anyURL(), statusCode: code, httpVersion: nil, headerFields: [:])!
            let result = ItemsMapper.map(invalidData(), response)
            assertResult(
                receivedResult: result,
                expectedResult: .failure(anyNSError()))
        }
    }
    
    func test_map_withInvalidDataAnd2xxResponse_returnFailure() {
        for code in validCodes() {
            let response = HTTPURLResponse(url: anyURL(), statusCode: code, httpVersion: nil, headerFields: [:])!
            let result = ItemsMapper.map(invalidData(), response)
            assertResult(
                receivedResult: result,
                expectedResult: .failure(anyNSError()))
        }
    }
    
    func test_map_withValidDataAnd2xxResponse_returnSuccessWithItems() {
        let (items, data) = makeItems()
        for code in validCodes() {
            let response = HTTPURLResponse(url: anyURL(), statusCode: code, httpVersion: nil, headerFields: [:])!
            let result = ItemsMapper.map(data, response)
            assertResult(
                receivedResult: result,
                expectedResult: .success(items.map{ $0.model }))
        }
    }
    
    func test_map_withValidDataAndNon2xxResponse_returnFailure() {
        let (_, data) = makeItems()
        for code in invalidCodes() {
            let response = HTTPURLResponse(url: anyURL(), statusCode: code, httpVersion: nil, headerFields: [:])!
            let result = ItemsMapper.map(data, response)
            assertResult(
                receivedResult: result,
                expectedResult: .failure(anyNSError()))
        }
    }
    
    private func assertResult(receivedResult: ItemsMapper.Result, expectedResult: ItemsMapper.Result, file: StaticString = #file, line: UInt = #line) {
        switch (receivedResult, expectedResult) {
        case (.failure, .failure): break
        case let (.success(receiveItems), .success(expectedItems)):
            XCTAssertEqual(receiveItems, expectedItems, file: file, line: line)
        default: XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
        }
    }

}
