//
//  ShowImageDataMapperTests.swift
//  PopcornCoreTests
//
//  Created by Anne on 09/12/22.
//

import PopcornCore
import XCTest

class ShowImageDataMapperTests: XCTestCase {
    
    func test_map_throwsErrorOnNon200HTTPResponse() throws {
        let samples = [199, 201, 300, 400, 500]
        
        try samples.forEach { code in
            XCTAssertThrowsError(
                try ShowImageDataMapper.map(anyData(), from: HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_map_deliversInvalidDataErrorOn200HTTPResponseWithEmptyData() {
        let emptyData = Data()
        
        XCTAssertThrowsError(
            try ShowImageDataMapper.map(emptyData, from: HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_map_deliversReceivedNonEmptyDataOn200HTTPResponse() throws {
        let nonEmptyData = Data("non-empty data".utf8)
        
        let result = try ShowImageDataMapper.map(nonEmptyData, from: HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, nonEmptyData)
    }
}
