//
//  String+Random.swift
//  PopcornCoreTests
//
//  Created by Anne on 12/12/22.
//

import Foundation

extension String {
    static func random(length: Int = 10) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
