//
//  LoginNetworkController.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import Foundation

typealias loginCompletionHandler = (_ response: Result<LoginServiceResponseModel>) -> Void

protocol LoginSceneNetworkCasesProtocol {
    func login(username: String, password: String, completionHandler: @escaping loginCompletionHandler)
}

class LoginNetworkController: BasicNetworkController, LoginSceneNetworkCasesProtocol {
    
    func login(username: String, password: String, completionHandler: @escaping loginCompletionHandler) {
        
        let request = LoginServiceRequestModel(loginParameters: LoginParameters(username: username, password: password))

        execute(request: request) { (result: Result<BasicResponseModel<RootResponseModel<LoginServiceResponseModel>>>) in
            switch result {
            case let .success(response):
                if response.entity.successful, let resp = response.entity.response {
                    completionHandler(.success(resp))
                } else {
                    let error = CoreError(message: response.entity.description)
                    completionHandler(.failure(error))
                }
            case let .failure(error):
                completionHandler(.failure(error))
            }
        }
    }
    
}
