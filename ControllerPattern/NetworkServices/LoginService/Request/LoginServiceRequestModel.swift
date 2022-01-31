//
//  LoginServiceRequestModel.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import Foundation

struct LoginParameters {
    var username: String
    var password: String
}

struct LoginServiceRequestModel: BasicRequestModel {
    let loginParameters: LoginParameters
    
    var urlRequest: URLRequest {
        let url: URL! = URL(string: LOGIN_URL)
        var request = URLRequest(url: url)
        
        request.httpBody = loginParameters.toJSONString().data(using: .utf8)
        request.timeoutInterval = TimeInterval(TimeOutTime)
        request.setValue("application/json", forHTTPHeaderField: "content-type")
        request.setValue("en", forHTTPHeaderField: "Accept-Language")
        request.httpMethod = "POST"
        
        return request
    }
}

extension LoginParameters {
    func toJSONString() -> String {
        var dictionary = [String: Any]()
        
        dictionary["username"] = username
        dictionary["password"] = password

        return dictionary.convertToJson()
    }
}
