//
//  ShowsLocalizationTests.swift
//  PopcornCoreTests
//
//  Created by Anne on 09/12/22.
//

import PopcornCore
import XCTest

final class ShowsLocalizationTests: XCTestCase {
    
    func test_localizedStrings_haveKeysAndValuesForAllSupportedLocalizations() {
        let table = "Shows"
        let bundle = Bundle(for: ShowsPresenter.self)
        
        assertLocalizedKeyAndValuesExist(in: bundle, table)
    }
}
