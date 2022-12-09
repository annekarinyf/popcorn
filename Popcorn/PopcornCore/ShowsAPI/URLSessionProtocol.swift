//
//  URLSessionProtocol.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public protocol URLSessionProtocol {
    func dataTask(
        with url: URL,
        completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void
    ) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {}
