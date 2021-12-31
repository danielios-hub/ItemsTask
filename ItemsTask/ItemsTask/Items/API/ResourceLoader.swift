//
//  ResourceLoader.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import Foundation

public final class ResourceLoader<Resource> {
    public typealias Result = Swift.Result<Resource, Swift.Error>
    public typealias Mapper = (Data, HTTPURLResponse) -> Result
    
    let url: URL
    let client: HTTPClient
    let mapper: Mapper
    
    public init(url: URL, client: HTTPClient, mapper: @escaping Mapper) {
        self.url = url
        self.client = client
        self.mapper = mapper
    }
    
    public func load(completion: @escaping (Result) -> Void) {
        client.get(url, headers: [], completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success((data, response)):
                completion(self.mapper(data, response))
            case let .failure(error):
                completion(.failure(error))
            }
        })
    }
    
}
