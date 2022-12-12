//
//  ShowViewModel.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public struct ShowViewModel {
    public let name: String?
    public let status: String?
    public let language: String?
    public let summary: String?
    
    public init(name: String?, status: String?, language: String?, summary: String?) {
        self.name = name
        self.status = status
        self.language = language
        self.summary = summary
    }
}
