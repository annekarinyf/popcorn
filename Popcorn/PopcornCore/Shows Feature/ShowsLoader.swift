//
//  ShowsLoader.swift
//  PopcornCore
//
//  Created by Anne on 10/12/22.
//

public protocol ShowLoader {
    typealias Result = Swift.Result<[Show], Error>

    func load(completion: @escaping (ShowLoader.Result) -> Void)
}
