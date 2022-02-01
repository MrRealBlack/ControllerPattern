//
//  BasicCoreDataController.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/31/22.
//

import UIKit
import CoreData

class BasicCoreDataController {
    
    // MARK: - Variables
    
    struct Identifiers {
        static let User = "User"
    }
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Mutal functions

    func save() {
        do {
            try managedObjectContext.save()
        } catch {
            print("Error in saving")
        }
    }
}


