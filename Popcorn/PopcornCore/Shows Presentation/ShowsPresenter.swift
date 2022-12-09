//
//  ShowsPresenter.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public final class ShowsPresenter {
    public static var title: String {
        NSLocalizedString("SHOWS_VIEW_TITLE",
            tableName: "Shows",
            bundle: Bundle(for: ShowsPresenter.self),
            comment: "Title for the shows view")
    }
}
