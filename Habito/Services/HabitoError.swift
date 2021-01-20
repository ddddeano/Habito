//
//  HabitoError.swift
//  Habito
//
//  Created by Daniel Watson on 20/01/2021.
//

import Foundation

enum HabitoError: LocalizedError {
    case auth(description: String)
    case `default`(description: String? = nil)
    
    var errorDescription: String? {
        switch self {
        case let .auth(description):
            return description
        case let .default(description):
            return description ?? "Something wrong"
        }
    }
}
