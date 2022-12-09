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
    typealias DataTaskCompletion = (data: Data?, response: URLResponse?, error: Error?)
    typealias HTTPClientDataTaskHandler = ((HTTPClientDataTask) -> Void)
    
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
    
    func test_canCancelGetFromURL_cancelsURLRequest() {
        let exp = expectation(description: "Wait for request")
        
        URLProtocolStub.observeRequests { _ in exp.fulfill() }
        
        let cancelDataTaskHandler: HTTPClientDataTaskHandler = { task in
            task.cancel()
        }
        
        let receivedError = getErrorResult(taskHandler: cancelDataTaskHandler) as NSError?
        wait(for: [exp], timeout: 1.0)
        
        XCTAssertEqual(receivedError?.code, URLError.cancelled.rawValue)
    }
    
    func test_getFromURL_failsOnRequestError() {
        let requestError = anyNSError()
        
        let receivedError = getErrorResult(for: DataTaskCompletion(data: nil, response: nil, error: requestError))
        
        XCTAssertNotNil(receivedError)
    }
    
    func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> HTTPClient {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [URLProtocolStub.self]
        let session = URLSession(configuration: configuration)
        
        let sut = URLSessionHTTPClient(session: session)
        return sut
    }
    
    private func getResult(
        for dataTaskCompletion: DataTaskCompletion?,
        taskHandler: HTTPClientDataTaskHandler = { _ in },
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> HTTPClient.Result {
        dataTaskCompletion.map { URLProtocolStub.stub(data: $0, response: $1, error: $2) }
        
        let sut = makeSUT(file: file, line: line)
        let exp = expectation(description: "Wait for completion")
        
        var receivedResult: HTTPClient.Result!
        taskHandler(sut.get(from: anyURL()) { result in
            receivedResult = result
            exp.fulfill()
        })
        
        wait(for: [exp], timeout: 1.0)
        return receivedResult
    }
    
    private func getSuccessResult(
        for dataTaskCompletion: DataTaskCompletion? = nil,
        taskHandler: HTTPClientDataTaskHandler = { _ in },
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (data: Data?, response: URLResponse?)? {
        let result = getResult(for: dataTaskCompletion, taskHandler: taskHandler, file: file, line: line)
        
        switch result {
        case let .success(values):
            return values
        default:
            XCTFail("Expected success, got \(result) instead", file: file, line: line)
            return nil
        }
    }
    
    private func getErrorResult(
        for dataTaskCompletion: DataTaskCompletion? = nil,
        taskHandler: HTTPClientDataTaskHandler = { _ in },
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> Error? {
        let result = getResult(for: dataTaskCompletion, taskHandler: taskHandler, file: file, line: line)
        
        switch result {
        case let .failure(error):
            return error
        default:
            XCTFail("Expected failure, got \(result) instead", file: file, line: line)
            return nil
        }
    }
}
