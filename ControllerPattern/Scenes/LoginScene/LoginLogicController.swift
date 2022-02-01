//
//  LoginLogicController.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import Foundation

protocol LoginViewControllerProtocol {
    func display(error: String)
    func showLoading()
    func hideLoading()
}

protocol LoginLogicControllerProtocol: BasicLogicProtocol {
    func login(username: String, password: String)
}

class LoginLogicController: BasicLogicController, LoginLogicControllerProtocol {
    
    var coreDataController: UserCoreDataControllerProtocol
    var networkController: LoginNetworkControllerProtocol
    var routingController: LoginRoutingControllerProtocol
    var loginViewController: LoginViewControllerProtocol
    
    init(loginView: LoginViewControllerProtocol, router: LoginRoutingControllerProtocol) {
        self.loginViewController = loginView
        routingController = router
        coreDataController = UserCoreDataController()
        networkController = LoginNetworkController(urlSessionConfiguration: URLSessionConfiguration.default,
                                                   completionHandlerQueue: OperationQueue.main)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func login(username: String, password: String) {
        if validate(username: username, password: password) {
            routingController.showLoading()
            networkController.login(username: username, password: password) { result in
                self.routingController.hideLoading()
                switch result {
                case .success(let data):
                    UserDefaults.token = data.token
                    self.coreDataController.setUser(UserModel(username: data.username, role: data.role, id: data.userId))
                    self.routingController.showHomePage()
                case .failure(let error):
                    self.loginViewController.display(error: error.message)
                }
            }
        }
    }
    
    func validate(username: String, password: String) -> Bool {
        if username.count == 0 {
            loginViewController.display(error: "Please enter username")
            return false
        } else if password.count == 0 {
            loginViewController.display(error: "Please enter password")
            return false
        } else {
            loginViewController.display(error: "")
            return true
        }
    }
    
}
