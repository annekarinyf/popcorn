//
//  Shows API Test Helpers.swift
//  PopcornCoreTests
//
//  Created by Anne on 11/12/22.
//

import Foundation
import PopcornCore

func makeShow(
    id: UUID = UUID(),
    url: URL = anyURL(),
    name: String? = nil,
    status: String? = nil,
    language: String? = nil,
    summary: String? = nil,
    image: ShowImage?
) -> (model: Show, json: [String: Any]) {
    let item = Show(id: id, url: url, name: name, status: status, language: language, summary: summary, image: image)
    
    let json: [String: Any?] = [
        "id": id.uuidString,
        "url": url.absoluteString,
        "name": name,
        "status": status,
        "language": language,
        "summary": summary,
        "image": [
            "medium": image?.medium,
            "original": image?.original
        ].compactMapValues { $0 }
    ]
    
    return (item, json.compactMapValues { $0 })
}
