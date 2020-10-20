//
//  NetworkError.swift
//  FetchHiring
//
//  Created by Nick Nguyen on 10/19/20.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case noData
    case badNetwork
    case badResponse
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .badNetwork: return ""
            case .badResponse:return ""
            case .badURL:return ""
            case .noData:return ""
        }
    }

    var recoverySuggestion: String? {
        switch self {
            case .badNetwork:return ""
            case .badResponse:return ""
            case .badURL:return ""
            case .noData:return ""
        }
    }
}
