//
//  URLDataTaskProtocol.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public protocol URLSessionDataTaskProtocol {
  func resume()
  func cancel()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol {}
