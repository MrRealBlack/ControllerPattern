//
//  UserDefaults.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/31/22.
//

import UIKit

extension UserDefaults {
    
    struct UserDefaultKeys {
        static let token = "token"
    }
    
    class func clearAll() {
        UserDefaults.standard.removeObject(forKey: UserDefaults.UserDefaultKeys.token)
    }
    
    class func removeAll() {
        UserDefaults.standard.removePersistentDomain(forName: Bundle.main.bundleIdentifier ?? "")
        UserDefaults.standard.synchronize()
    }
    
    class var token: String {
        get {
            if let token = UserDefaults.standard.object(forKey: UserDefaults.UserDefaultKeys.token) as? String {
                return token
            } else {
                return ""
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: UserDefaults.UserDefaultKeys.token)
        }
    }
    
}
