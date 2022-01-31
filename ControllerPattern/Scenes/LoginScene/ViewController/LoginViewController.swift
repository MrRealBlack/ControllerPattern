//
//  ViewController.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import UIKit

class LoginViewController: BasicViewController , BasicViewControllerPropertiesProtocol, LoginViewProtocol {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    var logicController: LoginLogicController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLogicController()
        logicController.viewDidLoad()
    }
    
    func setLogicController() {
        logicController = LoginLogicController(loginScene: self)
    }

    @IBAction func logicButtonTouchUpInSide(_ sender: Any) {
        logicController.login(username: usernameTextField.text!, password: passwordTextField.text!)
    }
    
    func display(error: String) {
        errorLabel.text = error
    }
    
    func showLoading() {
        activityIndicator.isHidden = false
    }
    
    func hideLoading() {
        activityIndicator.isHidden = true
    }
    
}

