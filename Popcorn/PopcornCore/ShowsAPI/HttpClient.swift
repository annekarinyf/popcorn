//
//  HttpClient.swift
//  PopcornCore
//
//  Created by Anne on 08/12/22.
//

import Foundation

public protocol HTTPClient {
    typealias Result = Swift.Result<(Data, HTTPURLResponse), Error>

    func get(from url: URL, completion: @escaping (HTTPClient.Result) -> Void)
}
