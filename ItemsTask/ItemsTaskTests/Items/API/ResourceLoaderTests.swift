//
//  ResourceLoaderTests.swift
//  SomeCompanyTaskTests
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import XCTest
import ItemsTask

class ResourceLoaderTests: XCTestCase {

    func test_load_withError_shouldDeliverError() {
        let (sut, client, _) = makeSUT()
        
        assert(sut: sut, toCompleteWith: .failure(anyNSError()), when: {
            client.complete(with: anyNSError())
        })
    }
    
    func test_load_withMapError_shouldDeliverMapError() {
        let (sut, client, mapper) = makeSUT()
        mapper.result = .failure(anyNSError())
        
        assert(sut: sut, toCompleteWith: .failure(anyNSError()), when: {
            client.complete(with: anyData(), response: anyHTTPResponse())
        })
    }
    
    func test_load_withSuccessMap_deliverSuccessWithMappedResource() {
        let (sut, client, mapper) = makeSUT()
        let resource = "Any String"
        mapper.result = .success(resource)
        
        assert(sut: sut, toCompleteWith: .success(resource), when: {
            client.complete(with: anyData(), response: anyHTTPResponse())
        })
    }
    
    private func assert(
        sut: ResourceLoader<MapperStub.StubType>,
        toCompleteWith result: Result<ResourceLoaderTests.MapperStub.StubType, Error>,
        when action: () -> Void,
        file: StaticString = #file,
        line: UInt = #line) {
        let exp = expectation(description: "Wait for completion")
        sut.load { receivedResult in
            switch (receivedResult, result) {
            case let (.success(receivedResource), .success(expectedResource)):
                XCTAssertEqual(receivedResource, expectedResource, file: file, line: line)
            case (.failure, .failure): break
            default: XCTFail("Expected \(result), got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
            
        action()
        wait(for: [exp], timeout: 1)
    }
    
    func test_load_withInstanceDeallocated_doesNotComplete() {
        let mapper = MapperStub()
        let client = HTTPClientSpy()
        var sut: ResourceLoader? = ResourceLoader(url: anyURL(), client: client, mapper: mapper.map)
        
        sut?.load { _ in }
        sut = nil
        client.complete(with: anyData(), response: anyHTTPResponse())
    }
    
    //MARK: - Helpers
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (ResourceLoader<MapperStub.StubType>, HTTPClientSpy, MapperStub) {
        let mapper = MapperStub()
        let client = HTTPClientSpy()
        let sut = ResourceLoader(url: anyURL(), client: client, mapper: mapper.map)
        tracksForMemoryLeaks(sut)
        tracksForMemoryLeaks(client)
        tracksForMemoryLeaks(mapper)
        return (sut, client, mapper)
    }
    
    private func anyHTTPResponse() -> HTTPURLResponse {
        return HTTPURLResponse(url: anyURL(), statusCode: 200, httpVersion: nil, headerFields: [:])!
    }
    
    private class MapperStub {
        typealias StubType = String
        typealias Result = Swift.Result<StubType, Swift.Error>
        var result: Result?
        
        func map(_ data: Data, _ response: HTTPURLResponse) -> Result {
            return result!
        }
    }
    
    private class HTTPClientSpy: HTTPClient {
        private var completions = [Completion]()
        
        func get(_ url: URL, headers: [HTTPHeader], completion: @escaping Completion) {
            completions.append(completion)
        }
        
        func complete(with error: Error, at index: Int = 0) {
            completions[index](.failure(error))
        }
        
        func complete(with data: Data, response: HTTPURLResponse, at index: Int = 0) {
            completions[index](.success((data, response)))
        }
        
    }

}
