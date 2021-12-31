//
//  HTTPClient.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import Foundation

public enum HTTPHeader {
    case json
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Swift.Error>
    typealias Completion = (Result) -> Void
    func get(_ url: URL, headers: [HTTPHeader], completion: @escaping Completion)
}
