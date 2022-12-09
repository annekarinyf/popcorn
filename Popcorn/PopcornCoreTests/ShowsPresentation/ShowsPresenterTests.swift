//
//  ShowsPresenterTests.swift
//  PopcornCoreTests
//
//  Created by Anne on 09/12/22.
//

import PopcornCore
import XCTest

final class ShowsPresenterTests: XCTestCase {
    
    func test_title_isLocalized() {
        XCTAssertEqual(ShowsPresenter.title, localized("SHOWS_VIEW_TITLE"))
    }
    
    // MARK: - Helpers
    
    private func localized(_ key: String, file: StaticString = #filePath, line: UInt = #line) -> String {
        let table = "Shows"
        let bundle = Bundle(for: ShowsPresenter.self)
        let value = bundle.localizedString(forKey: key, value: nil, table: table)
        if value == key {
            XCTFail("Missing localized string for key: \(key) in table: \(table)", file: file, line: line)
        }
        return value
    }
    
}
