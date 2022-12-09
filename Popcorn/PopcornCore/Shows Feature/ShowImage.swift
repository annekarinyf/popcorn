//
//  ShowImage.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

public struct ShowImage: Hashable {
    public let medium: String?
    public let original: String?
    
    public init(medium: String?, original: String?) {
        self.medium = medium
        self.original = original
    }
}
