//
//  SharedTestHelpers.swift
//  PopcornCoreTests
//
//  Created by Anne on 09/12/22.
//

import Foundation

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyData() -> Data {
    return Data("any data".utf8)
}
