//
//  RemoteShowLoader.swift
//  PopcornCore
//
//  Created by Anne on 10/12/22.
//

import Foundation

public final class RemoteShowLoader {
    private let url: URL
    private let client: HTTPClient

    public typealias Result = ShowLoader.Result

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
    }

    public init(client: HTTPClient, url: URL) {
        self.client = client
        self.url = url
    }

    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { [weak self] result in
            guard self != nil else {
                return
            }
            switch result {
            case .success((let data, let response)):
                completion(RemoteShowLoader.map(data, response))
            case .failure:
                completion(.failure(RemoteShowLoader.Error.connectivity))
            }
        }
    }
    
    private static func map(_ data: Data, _ response: HTTPURLResponse) -> Result {
        do {
            let items = try ShowMapper.map(data, from: response)
            return .success(items)
        } catch {
            return .failure(error)
        }
    }
}

