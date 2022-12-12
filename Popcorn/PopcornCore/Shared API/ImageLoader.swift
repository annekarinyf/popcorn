//
//  ImageLoader.swift
//  PopcornCore
//
//  Created by Anne on 12/12/22.
//

import Foundation

public final class ImageLoader: ImageDataLoader {
    private let client: URLSessionHTTPClient
    
    public init(client: URLSessionHTTPClient) {
        self.client = client
    }
    
    private struct ImageDataTaskWrapper: ImageDataLoaderTask {
        let wrapped: URLSessionDataTask
        
        func cancel() {
            wrapped.cancel()
        }
    }
    
    public func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) {
        client.get(from: url) { result in
            completion(Result {
                switch result {
                case .success((let data, _)):
                    return data
                case .failure(let error):
                    throw error
                }
            })
        }
    }    
}
