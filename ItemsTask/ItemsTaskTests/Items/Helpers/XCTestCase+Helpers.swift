//
//  XCTestCase+Helpers.swift
//  SomeCompanyTaskTests
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import Foundation
import XCTest

extension XCTestCase {
    func tracksForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Potential memory leaks, \(String(describing: instance)) not deallocated", file: file, line: line)
        }
    }
}
