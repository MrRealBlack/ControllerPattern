//
//  LoginServiceResponseModel.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import Foundation

struct LoginServiceResponseModel: InitializableWithData, InitializableWithJson {
    
    var userId: String = ""
    var token: String = ""
    var username: String = ""
    var role: String = ""

    init(data: Data?) throws {
        // Here you can parse the JSON or XML using the build in APIs or your favorite libraries
        guard let data = data,
            let jsonObject = try? JSONSerialization.jsonObject(with: data),
            let json = jsonObject as? [String: Any] else {
                throw NSError.createPraseError()
        }
        
        try self.init(json: json)
        
    }
    
    init(json: [String : Any]) throws {
        if let response = json["userId"] as? String {
            userId = response
        }
        
        if let response = json["token"] as? String {
            token = response
        }
        
        if let response = json["username"] as? String {
            username = response
        }
        
        if let response = json["role"] as? String {
            role = response
        }
    }
}
