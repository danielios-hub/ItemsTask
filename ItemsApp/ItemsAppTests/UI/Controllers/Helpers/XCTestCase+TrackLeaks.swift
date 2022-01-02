//
//  XCTestCase+TrackLeaks.swift
//  ItemsAppTests
//
//  Created by Daniel Gallego Peralta on 2/1/22.
//

import XCTest

extension XCTestCase {
    func tracksForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Potential memory leaks, \(String(describing: instance)) not deallocated", file: file, line: line)
        }
    }
}
