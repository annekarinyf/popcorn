//
//  ImageDataLoader.swift
//  PopcorniOS
//
//  Created by Anne on 12/12/22.
//

import Foundation

public protocol ImageDataLoader {
    typealias Result = Swift.Result<Data?, Error>
    
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void)
}
