//
//  RemoteShowLoaderTests.swift
//  PopcornCoreTests
//
//  Created by Anne on 10/12/22.
//

import PopcornCore
import XCTest

final class RemoteShowLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSut(url: URL(string: "test-url.com")!)

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestsDataFromURL() {
        let url = URL(string: "test-url.com")!
        let (sut, client) = makeSut(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "test-url.com")!
        let (sut, client) = makeSut(url: url)
        
        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSut()
        
        expectLoad(sut, toCompleteWithResult: .failure(RemoteShowLoader.Error.connectivity), when: {
            let clientError = NSError(domain: "Error", code: 0)
            client.complete(with: clientError)
        })
    }
    
    func test_load_deliversErrorOnNon220HTTPResponse() {
        let statusCodeSamples = [199, 201, 300, 400, 500]
        
        let (sut, client) = makeSut()
        
        statusCodeSamples.enumerated().forEach { index, code in
            expectLoad(sut, toCompleteWithResult: .failure(RemoteShowLoader.Error.invalidData), when:  {
                let itemsJSON = makeJSONValues([])
                client.complete(withStatusCode: code, data: itemsJSON, at: index)
            })
        }
    }
    
    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSut()
        
        expectLoad(sut, toCompleteWithResult: .failure(RemoteShowLoader.Error.invalidData), when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }
    
    func test_load_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() {
        let (sut, client) = makeSut()
        
        expectLoad(sut, toCompleteWithResult: .success([]), when: {
            let json = makeJSONValues([])
            client.complete(withStatusCode: 200, data: json)
        })
    }
    
    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSut()
        let show = Show.fixture()
        let showJSON = makeShowJSON(show: show)
        
        expectLoad(sut, toCompleteWithResult: .success([show]), when: {
            let json = makeJSONValues([showJSON])
            client.complete(withStatusCode: 200, data: json)
        })
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstanceHasBeenDeallocated() {
        let client = HTTPClientSpy()
        var sut: RemoteShowLoader? = RemoteShowLoader(client: client, url: URL(string: "test-url.com")!)
        
        var capturedResults = [RemoteShowLoader.Result]()
        sut?.load { capturedResults.append($0) }
        
        sut = nil
        
        client.complete(withStatusCode: 200, data: makeJSONValues([]))
        
        XCTAssertTrue(capturedResults.isEmpty)
    }

    @discardableResult
    func makeSut(
        url: URL = URL(string: "test-url.com")!,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: RemoteShowLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteShowLoader(client: client, url: url)

        trackForMemoryLeaks(client, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)

        return (sut, client)
    }
    
    func expectLoad(
        _ sut: RemoteShowLoader,
        toCompleteWithResult expectedResult: RemoteShowLoader.Result,
        when action: () -> Void,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        
        let exp = expectation(description: "Wait for load completion")
        
        sut.load { receivedResult in
            switch(receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
                
            case let (.failure(receivedError as RemoteShowLoader.Error), .failure(expectedError as RemoteShowLoader.Error)):
                XCTAssertEqual(receivedError, expectedError, file: file, line: line)
                
            default:
                XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            
            exp.fulfill()
        }
        
        action()
        
        wait(for: [exp], timeout: 1.0)
    }
}
