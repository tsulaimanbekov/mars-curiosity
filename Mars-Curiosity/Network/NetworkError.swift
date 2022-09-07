//
//  NetworkError.swift
//  Mars-Curiosity
//
//  Created by Tilek Sulaymanbekov on 6/9/22.
//

import Foundation


enum NetworkError: LocalizedError {
    
    case invalidServerResponse
    case invalidURL
    
    public var errorDescription: String? {
        switch self {
        case .invalidServerResponse:
            return "The server returned an invalid response."
        case .invalidURL:
            return "URL is not valid."
        }
    }
}
