//
//  LoginRoutingController.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import UIKit

protocol LoginRoutingControllerProtocol: RouterMainProtocol {
    func showHomePage()
}

class LoginRoutingController: BasicRoutingController, LoginRoutingControllerProtocol {
    
    var presenter: LoginViewController
    
    init(presenter: LoginViewController) {
        self.presenter = presenter
    }
    
    func showLoading() {
        presenter.showLoading()
    }
    
    func hideLoading() {
        presenter.hideLoading()
    }
    
    func showHomePage() {
        
    }
    
}
