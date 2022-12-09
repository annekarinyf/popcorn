//
//  ShowImageDataLoader.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public protocol ShowImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
