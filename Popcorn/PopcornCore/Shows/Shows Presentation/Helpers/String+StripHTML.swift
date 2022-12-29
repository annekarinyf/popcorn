//
//  String+StripHTML.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public extension String {
    func stripHTML() -> String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
}
