//
//  UIButton+TestHelpers.swift
//  PopcorniOSTests
//
//  Created by Anne on 12/12/22.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
