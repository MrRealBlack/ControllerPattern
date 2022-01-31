//
//  UserCoreDataController.swift
//  ControllerPattern
//
//  Created by Mehdi Gilanpour on 1/31/22.
//

import UIKit
import CoreData

struct UserModel {
    var username: String
    var role: String
    var id: String
}

class UserCoreDataController: BasicCoreDataController {
    
    static let instance = UserCoreDataController()

    fileprivate func modelToManagedObject(_ model: UserModel) -> User {
        let data = User(context: managedObjectContext)
        data.username = model.username
        data.role = model.role
        data.id = model.id
        return data
    }
    
    fileprivate func managedObjectToModel(_ object: User) -> UserModel {
        return UserModel(username: object.username ?? "", role: object.role ?? "", id: object.id ?? "")
    }
    
    func setUser(_ user: UserModel) {
        managedObjectContext.insert(modelToManagedObject(user))
        save()
    }
    
    func getUsers() -> [UserModel] {
        let fetchRequest = NSFetchRequest<User>(entityName: Identifiers.User)
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            return users.map({ managedObjectToModel($0) })
        } catch {
            return []
        }
    }

    func getUser(byId id: String) -> UserModel? {
        return getUsers().filter({ $0.id == id }).first
    }
    
    func deleteAllUsers() {
        let fetchRequest = NSFetchRequest<User>(entityName: Identifiers.User)
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            users.forEach({ managedObjectContext.delete($0) })
            save()
        } catch let error {
            print(error)
        }
    }
    
    func editUser(_ editedUser: UserModel) {
        guard let user = getUser(byId: editedUser.id) else { return }
        let managedObject = modelToManagedObject(user)
        managedObject.setValue(user.username, forKey: "username")
        managedObject.setValue(user.role, forKey: "role")
        save()
    }
    
    func deleteUser(_ user: UserModel) {
        let fetchRequest = NSFetchRequest<User>(entityName: Identifiers.User)
        do {
            let users = try managedObjectContext.fetch(fetchRequest)
            for i in 0..<users.count {
                if users[i].username == user.username {
                    managedObjectContext.delete(users[i])
                    save()
                    return
                }
            }
        } catch {
            
        }
    }
    
    func isUserExists(with id: String) -> Bool {
        return getUsers().filter({ $0.id == id }).count != 0
    }
}
