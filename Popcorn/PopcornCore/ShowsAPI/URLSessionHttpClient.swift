//
//  URLSessionHttpClient.swift
//  PopcornCore
//
//  Created by Anne on 08/12/22.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSessionProtocol

    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }

    private struct UnexpectedValuesRepresentation: Error { }

    public func get(from url: URL, completion: @escaping(HTTPClient.Result) -> Void) {
        session.dataTask(with: url) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }.resume()
    }
}
