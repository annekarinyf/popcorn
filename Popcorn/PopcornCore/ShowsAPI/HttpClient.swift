//
//  HttpClient.swift
//  PopcornCore
//
//  Created by Anne on 08/12/22.
//

import Foundation

public protocol HTTPClientDataTask {
    func cancel()
}

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    @discardableResult
    func get(from url: URL, completion: @escaping (Result) -> Void) -> HTTPClientDataTask
}
