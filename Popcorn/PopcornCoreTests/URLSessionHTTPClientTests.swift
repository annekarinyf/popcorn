//
//  URLSessionHTTPClientTests.swift
//  PopcornCoreTests
//
//  Created by Anne on 08/12/22.
//

import Foundation
import PopcornCore
import XCTest

final class URLSessionHTTPClientTests: XCTestCase {
    override func tearDown() {
        super.tearDown()
        URLProtocolStub.removeStub()
    }
    
    func test_getFromURL_performsGETRequestWithURL() {
        let sut = makeSUT()
        let url = anyURL()
        let exp = expectation(description: "Wait for request")
        
        let observer: ((URLRequest) -> Void) = { request in
            XCTAssertEqual(request.url, url)
            XCTAssertEqual(request.httpMethod, "GET")
            exp.fulfill()
        }
        
        URLProtocolStub.observeRequests(observer: observer)
        
        sut.get(from: url, completion: { _ in })
        
        wait(for: [exp], timeout: 1.0)
    }
    
    func makeSUT() -> URLSessionHTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        
        let sut = URLSessionHTTPClient(session: session)
        return sut
    }
}


