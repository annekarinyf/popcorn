//
//  Show.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public struct Show: Hashable {
    public let id: UUID
    public let url: URL
    public let name: String?
    public let status: String?
    public let language: String?
    public let summary: String?
    public let image: ShowImage?
    
    public init(
        id: UUID,
        url: URL,
        name: String?,
        status: String?,
        language: String?,
        summary: String?,
        image: ShowImage?
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
