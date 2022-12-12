//
//  UIRefreshControl+TestHelpers.swift
//  PopcorniOSTests
//
//  Created by Anne on 12/12/22.
//

import UIKit

extension UIRefreshControl {
    func simulatePullToRefresh() {
        simulate(event: .valueChanged)
    }
}
