//
//  Dictionary.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import Foundation

extension Dictionary {
    
    func convertToJson() -> String {
        
        var Json : String!
        let dictionary = self
        if let theJSONData = try? JSONSerialization.data(
            withJSONObject: dictionary,
            options: []) {
            let theJSONText = String(data: theJSONData,encoding: .utf8)
            Json = theJSONText
        }
        return Json
        
    }
    
}
