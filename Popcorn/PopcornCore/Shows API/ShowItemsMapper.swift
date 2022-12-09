//
//  ShowItemsMapper.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public final class ShowItemsMapper {
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Show] {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw Error.invalidData
        }
        
        return root.shows
    }
}

// MARK: - Decodable Models
extension ShowItemsMapper {
    private struct Root: Decodable {
        private let items: [ShowItem]
        
        private struct ShowItem: Decodable {
            public let id: UUID
            public let url: URL
            public let name: String?
            public let status: String?
            public let language: String?
            public let summary: String?
            public let image: ShowImageItem?
        }
        
        private struct ShowImageItem: Decodable {
            public let medium: String?
            public let original: String?
        }
        
        var shows: [Show] {
            items.map { Show(
                id: $0.id,
                url: $0.url,
                name: $0.name,
                status: $0.status,
                language: $0.language,
                summary: $0.summary,
                image: ShowImage(
                    medium: $0.image?.medium,
                    original: $0.image?.original
                )
            )}
        }
    }
}
