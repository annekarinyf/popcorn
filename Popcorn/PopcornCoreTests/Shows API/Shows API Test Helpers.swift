//
//  Shows API Test Helpers.swift
//  PopcornCoreTests
//
//  Created by Anne on 11/12/22.
//

import Foundation
import PopcornCore

func makeShowJSON(
    show: Show = Show.fixture()
) -> [String: Any] {
    let json: [String: Any?] = [
        "id": show.id,
        "url": show.url.absoluteString,
        "name": show.name,
        "status": show.status,
        "language": show.language,
        "summary": show.summary,
        "image": [
            "medium": show.image.medium?.absoluteString,
            "original": show.image.original.absoluteString
        ].compactMapValues { $0 }
    ]
    
    return json.compactMapValues { $0 }
}

extension Show {
    static func fixture(
        id: Int = Int.random(in: 0...100),
        url: URL = anyURL(),
        name: String = String.random(),
        status: String = String.random(),
        language: String = String.random(),
        summary: String = String.random(),
        image: ShowImage = ShowImage.fixture()
    ) -> Show {
        Show(
            id: id,
            url: url,
            name: name,
            status: status,
            language: language,
            summary: summary,
            image: image
        )
    }
}

extension ShowImage {
    static func fixture(
        medium: URL = anyURL(),
        original: URL = anyURL()
    ) -> ShowImage {
        ShowImage(
            medium: medium,
            original: original
        )
    }
}
