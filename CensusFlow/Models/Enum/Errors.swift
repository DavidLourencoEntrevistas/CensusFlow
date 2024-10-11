//
//  Errors.swift
//  CensusFlow
//
//  Created by David Lourenço on 11/10/2024.
//

import Foundation

enum Errors : Error, CustomStringConvertible{
    
    case invalidUrl
    case invalidResponse
    case serverError(statusCode: Int)
    case decodingError(DecodingError)
    case unknownError(Error)
    
    var description: String {
        switch self{
        case .invalidUrl:
            return "Invalid URL."
        case .invalidResponse:
            return "Invalid response from server."
        case .serverError(let statusCode):
            return "Invalid response from server with status code \(statusCode)"
        case .decodingError(let error):
            return "Decoding error with description: \(error)"
        case .unknownError(let error):
            return "Unknown error with description: \(error)"
        }
    }
    
}
