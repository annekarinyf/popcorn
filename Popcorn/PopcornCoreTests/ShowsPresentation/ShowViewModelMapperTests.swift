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
        let show = Show.fixture()
        
        let viewModel = ShowViewModelMapper.map(show)
        
        XCTAssertEqual(viewModel.name, show.name)
        XCTAssertEqual(viewModel.status, show.status)
        XCTAssertEqual(viewModel.language, show.language)
        XCTAssertEqual(viewModel.summary, show.summary)
    }
}
