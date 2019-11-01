//
//  NetworkError.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    
    case noInternetConnection
    case custom(String)
    case other
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No Internet connection"
        case .other:
            return "Something went wrong"
        case .custom(let message):
            return message
        }
    }
}
