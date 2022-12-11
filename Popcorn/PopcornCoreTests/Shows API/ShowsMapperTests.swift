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
        let show1 = makeShow(
            id: UUID(),
            url: URL(string: "http://a-url.com")!,
            name: "a name",
            status: "a status",
            language: "a language",
            summary: "a summary",
            image: .init(
                medium: "a medium image",
                original: "an original image"
            )
        )
        
        let show2 = makeShow(
            id: UUID(),
            url: URL(string: "http://another-url.com")!,
            image: .init(
                medium: nil,
                original: nil
            )
        )
        
        let json = makeJSONValues([show1.json, show2.json])
        
        let result = try ShowMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [show1.model, show2.model])
    }
}
