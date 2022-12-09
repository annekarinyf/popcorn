//
//  ShowViewModelMapperTests.swift
//  PopcornCoreTests
//
//  Created by Anne on 09/12/22.
//

import PopcornCore
import XCTest

final class ShowViewModelMapperTests: XCTestCase {
    
    func test_map_createsViewModel() {
        let show = uniqueShow()
        
        let viewModel = ShowViewModelMapper.map(show)
        
        XCTAssertEqual(viewModel.name, show.name)
        XCTAssertEqual(viewModel.status, show.status)
        XCTAssertEqual(viewModel.language, show.language)
        XCTAssertEqual(viewModel.summary, show.summary)
    }
    
    func uniqueShow() -> Show {
        Show(
            id: UUID(),
            url: anyURL(),
            name: "name",
            status: "status",
            language: "language",
            summary: "summary",
            image: .init(
                medium: "medium",
                original: "original"
            )
        )
    }
}
