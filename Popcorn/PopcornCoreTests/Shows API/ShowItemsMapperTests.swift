//
//  ShowItemsMapperTests.swift
//  PopcornCoreTests
//
//  Created by Anne on 09/12/22.
//

import PopcornCore
import XCTest

final class ShowItemsMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let json = makeItemsJSON([])
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try ShowItemsMapper.map(json, from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_throwsErrorOn200HTTPResponseWithInvalidJSON() {
        let invalidJSON = Data("invalid json".utf8)
        
        XCTAssertThrowsError(
            try ShowItemsMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversNoItemsOn200HTTPResponseWithEmptyJSONList() throws {
        let emptyListJSON = makeItemsJSON([])
        
        let result = try ShowItemsMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: 200))
        
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
        
        let json = makeItemsJSON([show1.json, show2.json])
        
        let result = try ShowItemsMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, [show1.model, show2.model])
    }
    
    private func makeShow(
        id: UUID,
        url: URL,
        name: String? = nil,
        status: String? = nil,
        language: String? = nil,
        summary: String? = nil,
        image: ShowImage?
    ) -> (model: Show, json: [String: Any]) {
        let item = Show(id: id, url: url, name: name, status: status, language: language, summary: summary, image: image)
        
        let json: [String: Any?] = [
            "id": id.uuidString,
            "url": url.absoluteString,
            "name": name,
            "status": status,
            "language": language,
            "summary": summary,
            "image": [
                "medium": image?.medium,
                "original": image?.original
            ].compactMapValues { $0 }
        ]
        
        return (item, json.compactMapValues { $0 })
    }
}
