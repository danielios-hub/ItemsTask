//
//  ItemEndpointTests.swift
//  SomeCompanyTaskTests
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import XCTest
import ItemsTask

class ItemEndpointTests: XCTestCase {

    func test_get_shouldReturnGetURL() {
        let baseURL = "http://any-baseurl.com"
        let getAllURL = ItemEndpoint.getAll.url(baseURL: URL(string: baseURL)!)
        XCTAssertEqual(getAllURL.absoluteString, "\(baseURL)/items/contentList.json")
    }
    
    func test_getDetail_shouldReturnGetDetailURL() {
        let baseURL = "http://any-baseurl.com"
        let itemID = 36
        let getAllURL = ItemEndpoint.get(itemID).url(baseURL: URL(string: baseURL)!)
        XCTAssertEqual(getAllURL.absoluteString, "\(baseURL)/items/content/\(itemID).json")
    }

}
