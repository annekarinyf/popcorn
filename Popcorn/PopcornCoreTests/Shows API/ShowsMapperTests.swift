//
//  ShowsMapperTests.swift
//  PopcornCoreTests
//
//  Created by Anne on 09/12/22.
//

import PopcornCore
import XCTest

final class ShowsMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeJSONValues([])
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try ShowMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try ShowMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = makeJSONValues([])
        
        let result = try ShowMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [])
    }
    
    func test_map_deliversItemsOn200HTTPResponseWithJSONItems() throws {
        let show1 = Show.fixture(
            id: 1,
            url: URL(string: "http://a-url.com")!,
            name: "a name",
            status: "a status",
            language: "a language",
            summary: "a summary",
            image: .init(
                medium: URL(string: "http://m-image.com")!,
                original: URL(string: "http://o-image.com")!
            )
        )
        let show1JSON = makeShowJSON(show: show1)
        
        let show2 = Show.fixture(
            id: 2,
            url: URL(string: "http://another-url.com")!
        )
        let show2JSON = makeShowJSON(show: show2)
        
        let json = makeJSONValues([show1JSON, show2JSON])
        
        let result = try ShowMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [show1, show2])
    }
}
