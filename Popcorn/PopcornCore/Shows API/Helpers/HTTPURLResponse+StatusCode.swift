//
//  HTTPURLResponse+StatusCode.swift
//  PopcornCore
//
//  Created by Anne on 09/12/22.
//

import Foundation

extension HTTPURLResponse {
    private static var OK_200: Int { return 200 }
    
    var isOK: Bool {
        return statusCode == HTTPURLResponse.OK_200
    }
}
