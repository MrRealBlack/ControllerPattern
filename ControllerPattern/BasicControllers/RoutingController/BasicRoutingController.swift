//
//  BasicRoutingController.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import Foundation

protocol RouterMainProtocol {
    func loginAgain()
    func showLoading()
    func hideLoading()
}

extension RouterMainProtocol {
    func hideLoading() {}
    func showLoading() {}
}

class BasicRoutingController: RouterMainProtocol {
    
    func loginAgain() {
            
    }
    
}
