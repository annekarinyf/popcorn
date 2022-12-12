//
//  ShowsViewControllerTests.swift
//  PopcorniOSTests
//
//  Created by Anne on 12/12/22.
//

import PopcornCore
import PopcorniOS
import XCTest

final class ShowsViewControllerTests: XCTestCase {
    
    func test_loadShowsActions_requestShowsFromLoader() {
        let (sut, loader) = makeSUT()
        XCTAssertEqual(loader.loadShowsCallCount, 0, "Expected no loading requests before view is loaded")
        
        sut.loadViewIfNeeded()
        XCTAssertEqual(loader.loadShowsCallCount, 1, "Expected a loading request once view is loaded")
        
        sut.simulateUserInitiatedShowsReload()
        XCTAssertEqual(loader.loadShowsCallCount, 2, "Expected another loading request once user initiates a reload")
        
        sut.simulateUserInitiatedShowsReload()
        XCTAssertEqual(loader.loadShowsCallCount, 3, "Expected yet another loading request once user initiates another reload")
    }
    
    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> (sut: ShowsViewController, loader: LoaderSpy) {
        let loader = LoaderSpy()
        let sut = ShowsUIComposer.showsComposed(with: loader, imageLoader: loader)
        
        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        
        return (sut, loader)
    }
}
