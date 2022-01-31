//
//  BasicLogicController.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/28/22.
//

protocol BasicLogicProtocol {
    func viewDidLoad()
    func viewWillLayoutSubviews()
    func viewDidLayoutSubviews()
    func viewWillApear()
    func viewDidApear()
    func viewWillDisapear()
    func viewDidDisapear()
}

extension BasicLogicProtocol {
    func viewWillLayoutSubviews() {}
    func viewDidLayoutSubviews() {}
    func viewWillApear() {}
    func viewDidApear() {}
    func viewWillDisapear() {}
    func viewDidDisapear() {}
}

class BasicLogicController: BasicLogicProtocol {
    
    func viewDidLoad() {
        
    }
    
}
