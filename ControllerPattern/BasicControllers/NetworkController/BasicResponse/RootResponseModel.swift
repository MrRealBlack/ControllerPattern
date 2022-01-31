//
//  RootResponseModel.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import Foundation

struct RootResponseModel<T: InitializableWithJson>: InitializableWithData, InitializableWithJson {
    
    //You can change these properties as you want and match with your server side
    var successful : Bool = false
    var responseCode: String = ""
    var description: String = ""
    var response: T?

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
        if let response = json["successful"] as? Bool {
            successful = response
        }
        
        if let response = json["responseCode"] as? String {
            responseCode = response
        }
        
        if let response = json["description"] as? String {
            description = response
        }
        
        if let resp = json["response"] as? Dictionary<String, Any> {
            do {
                response =  try T(json: resp)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
