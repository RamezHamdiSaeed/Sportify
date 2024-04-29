//
//  NetworkError.swift
//  Sportify
//
//  Created by Hadir on 25/04/2024.
//

import Foundation

enum NetworkError: Error {
    var message: String {
        switch self {
        case .networkError(let networkMessage):
            return networkMessage
        default:
            return "Something went wrong"
        }
    }
    case networkError(message: String)
    case other
}
