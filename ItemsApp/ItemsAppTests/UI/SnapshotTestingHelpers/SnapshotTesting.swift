//
//  SnapshotTesting.swift
// ItemsAppTests
//
//  Created by Daniel Gallego Peralta on 19/12/21.
//

import XCTest

public struct SnapshotTesting {
    
    public typealias SnapshotKey = String
    
    public enum SnapshotStrategy {
        case record
        case assert
    }
    
    private static var values: [SnapshotKey: SnapshotStrategy] = [:]
    
    public static func strategy(for key: SnapshotKey, file: StaticString = #file, line: UInt = #line) -> SnapshotStrategy {
        guard let value = values[key] else {
            XCTFail("key: \(key) not existing in snapshots", file: file, line: line)
            return .assert
        }
                    
        return value
    }
    
    public static func insertIfNeeded(_ key: SnapshotKey, strategy: SnapshotStrategy) {
        if values[key] == nil {
            values[key] = strategy
        }
    }
}
