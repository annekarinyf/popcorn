//
//  ShowsViewController+Helpers.swift
//  PopcorniOSTests
//
//  Created by Anne on 12/12/22.
//

import UIKit
import PopcorniOS

extension ShowsViewController {
    func simulateUserInitiatedShowsReload() {
        refreshControl?.simulatePullToRefresh()
    }

    var isShowingLoadingIndicator: Bool {
        refreshControl?.isRefreshing == true
    }
}

