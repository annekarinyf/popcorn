//
//  HttpClientSpy.swift
//  PopcornCoreTests
//
//  Created by Anne on 12/12/22.
//

import Foundation
import PopcornCore

final class HTTPClientSpy: HTTPClient {
    private var messages = [(url: URL, completion: (HTTPClient.Result) -> Void)]()

    var requestedURLs: [URL] {
        messages.map { $0.url }
    }
    
    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void) {
        messages.append((url, completion))
    }

    func complete(with error: Error, at index: Int = 0) {
        messages[index].completion(.failure(error))
    }

    func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
        let response = HTTPURLResponse(
            url: requestedURLs[index],
            statusCode: code,
            httpVersion: nil,
            headerFields: nil
        )!
        messages[index].completion(.success((data, response)))
    }
}
