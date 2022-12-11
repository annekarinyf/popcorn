//
//  ShowsMapper.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public final class ShowMapper {
    public enum Error: Swift.Error {
        case invalidData
    }
    
    public static func map(_ data: Data, from response: HTTPURLResponse) throws -> [Show] {
        guard response.isOK, let root = try? JSONDecoder().decode([DecodableShow].self, from: data) else {
            throw RemoteShowLoader.Error.invalidData
        }
        
        return root.map { Show(
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
            )
        }
    }
}

// MARK: - Decodable Models
extension ShowMapper {
    private struct DecodableShow: Decodable {
        public let id: UUID
        public let url: URL
        public let name: String?
        public let status: String?
        public let language: String?
        public let summary: String?
        public let image: DecodableShowImage?
    }
    
    private struct DecodableShowImage: Decodable {
        public let medium: String?
        public let original: String?
    }
}
