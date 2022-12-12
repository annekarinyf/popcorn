//
//  ShowImage.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public struct ShowImage: Hashable {
    public let medium: URL?
    public let original: URL
    
    public init(medium: URL?, original: URL) {
        self.medium = medium
        self.original = original
    }
}
