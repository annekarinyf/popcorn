//
//  LoaderSpy.swift
//  PopcorniOSTests
//
//  Created by Anne on 12/12/22.
//

import Foundation
import PopcornCore

class LoaderSpy: ShowLoader, ImageDataLoader {

    // MARK: - ShowLoader
    
    private var showRequests = [(ShowLoader.Result) -> Void]()

    var loadShowsCallCount: Int {
        return showRequests.count
    }

    func load(completion: @escaping (ShowLoader.Result) -> Void) {
        showRequests.append(completion)
    }

    func completeShowLoading(with shows: [Show] = [], at index: Int = 0) {
        showRequests[index](.success(shows))
    }

    func completeShowLoadingWithError(at index: Int = 0) {
        let error = NSError(domain: "an error", code: 0)
        showRequests[index](.failure(error))
    }

    // MARK: - ImageDataLoader
    private var imageRequests = [(url: URL, completion: (ImageDataLoader.Result) -> Void)]()

    var loadedImageURLs: [URL] {
        return imageRequests.map { $0.url }
    }

    func loadImageData(from url: URL, completion: @escaping (ImageDataLoader.Result) -> Void) {
        imageRequests.append((url, completion))
    }

    func completeImageLoading(with imageData: Data = Data(), at index: Int = 0) {
        imageRequests[index].completion(.success(imageData))
    }

    func completeImageLoadingWithError(at index: Int = 0) {
        let error = NSError(domain: "an error", code: 0)
        imageRequests[index].completion(.failure(error))
    }
}
