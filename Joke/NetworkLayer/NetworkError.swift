//
//  NetworkError.swift
//  MVP_Medium
//
//  Created by Dheeraj Rathore  on 01/11/23.
//

import Foundation

enum APIError: Error {
    case requestFailed(description: String, errorCode: String = "")
    case jsonConversionFailure(description: String = "")
    case invalidData
    case responseUnsuccessful(description: String)
    case jsonParsingFailure
    case noInternet(description: String)
    case failedSerialization
    case validationFailed(description: String)
    case coolingPeriod(description: String)

    var customDescription: String {
        switch self {
        //remove the requst failed error message rather than that show downtime screen
        case .requestFailed(_, _): return ""
        case .invalidData: return "Invalid Data error)"
        case let .responseUnsuccessful(description): return "Response Unsuccessful error -> \(description)"
        case .jsonParsingFailure: return "JSON Parsing Failure error)"
        case let .jsonConversionFailure(description): return "JSON Conversion Failure -> \(description)"
        case let .noInternet(description): return "No internet connection -> \(description)"
        case .failedSerialization: return "serialization print for debug failed."
        case let .validationFailed(description): return description
        case let .coolingPeriod(description): return description
        }
    }
    
}
