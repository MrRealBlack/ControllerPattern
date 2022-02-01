//
//  asd.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

import UIKit

protocol BasicViewControllerPropertiesProtocol {
    func setLogicController()
}

extension BasicViewControllerPropertiesProtocol {
    func setLogicController() {}
}

class BasicViewController: UIViewController, BasicViewControllerPropertiesProtocol {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
