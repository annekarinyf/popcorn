//
//  URLSessionHttpClient.swift
//  PopcornCore
//
//  Created by Anne on 08/12/22.
//

import Foundation

public final class URLSessionHTTPClient: HTTPClient {
    private let session: URLSession
    
    public init(session: URLSession) {
        self.session = session
    }
    
    private struct UnexpectedValuesRepresentation: Error { }
    
    private struct URLSessionDataTask: HTTPClientDataTask {
        let dataTask: URLSessionTask
        
        func cancel() {
            dataTask.cancel()
        }
    }
    
    public func get(from url: URL, completion: @escaping(HTTPClient.Result) -> Void) -> HTTPClientDataTask {
        let dataTask = session.dataTask(with: url) { data, response, error in
            completion(Result {
                if let error = error {
                    throw error
                } else if let data = data, let response = response as? HTTPURLResponse {
                    return (data, response)
                } else {
                    throw UnexpectedValuesRepresentation()
                }
            })
        }
        
        dataTask.resume()
        
        return URLSessionDataTask(dataTask: dataTask)
    }
}
