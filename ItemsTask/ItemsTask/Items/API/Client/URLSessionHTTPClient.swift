//
//  URLSessionHTTPClient.swift
//  SomeCompanyTask
//
//  Created by Daniel Gallego Peralta on 18/12/21.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {

    private let session: URLSession

    enum HTTPMethod: String {
        case get = "GET"
    }
    
    enum APIError: Error {
        case fail
        case noDecodable
        case noDecodableRequest
    }

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func get(_ url: URL, headers: [HTTPHeader], completion: @escaping HTTPClient.Completion) {
        var request = request(for: url)
        request.httpMethod = HTTPMethod.get.rawValue

        if headers.isEmpty == false {
            request = setHeaders(&request, headers: headers)
        }

        perform(request, completion)
    }

    private func request(for url: URL) -> URLRequest {
        return URLRequest(url: url)
    }

    private func setHeaders(_ request: inout URLRequest, headers: [HTTPHeader]) -> URLRequest {
        headers.forEach { header in
            switch header {
            case .json:
                request.setValue("application/json", forHTTPHeaderField: "content-type")
            }
        }

        return request
    }

    private func perform(_ request: URLRequest, _ completion: @escaping HTTPClient.Completion) {
        session.dataTask(with: request) { data, response, _ in
            if let data = data,
               let response = response as? HTTPURLResponse {
                completion(.success((data, response)))
            } else {
                completion(.failure(APIError.fail))
            }
        }.resume()
    }

}
