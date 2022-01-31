//
//  URL.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import Foundation

let TimeOutTime = 5

#if PROD
private let MAIN_URL = "prod.com"
#elseif DEBUG
private let MAIN_URL = "dev.com"
#endif

private let BASE_URL = "https://\(MAIN_URL)/api/v1"
public let LOGIN_URL = "\(BASE_URL)/login"
