//
//  LocalShow.swift
//  PopcornCore
//
//  Created by anne.freitas on 29/12/22.
//

import Foundation

public struct LocalShow: Equatable {
    public let id: Int
    public let url: URL
    public let name: String
    public let status: String
    public let language: String
    public let summary: String
    public let image: LocalShowImage
    
    public init(
        id: Int,
        url: URL,
        name: String,
        status: String,
        language: String,
        summary: String,
        image: LocalShowImage
    ) {
        self.id = id
        self.url = url
        self.name = name
        self.status = status
        self.language = language
        self.summary = summary
        self.image = image
    }
}

public struct LocalShowImage: Equatable {
    public let medium: URL?
    public let original: URL
    
    public init(medium: URL?, original: URL) {
        self.medium = medium
        self.original = original
    }
}
