//
//  Result.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import Foundation

struct CoreError: Error {
    var localizedDescription: String {
        return message
    }
    
    var statusCode = 200
    var message = ""
}

enum Result<T> {
    case success(T)
    case failure(CoreError)
    
    public func dematerialize() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
