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
            case .badNetwork: return "Internet has problem"
            case .badResponse:return "Response is not successful"
            case .badURL:return "URL is not correct"
            case .noData:return "No data coming back from server"
        }
    }

    var recoverySuggestion: String? {
        switch self {
            case .badNetwork:return "Please check the internet and go back"
            case .badResponse:return "Something wrong with connection. Please check back later"
            case .badURL:return "Something wrong with the server. Please check back later"
            case .noData:return "No data from server. Please go back later."
        }
    }
}
