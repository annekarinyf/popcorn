//
//  ShowViewModelMapper.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public final class ShowViewModelMapper {
    public static func map(_ show: Show) -> ShowViewModel {
        ShowViewModel(
            name: show.name,
            status: show.status,
            language: show.language,
            summary: show.summary.stripHTML(),
            imageURL: show.image.medium ?? show.image.original
        )
    }
}
