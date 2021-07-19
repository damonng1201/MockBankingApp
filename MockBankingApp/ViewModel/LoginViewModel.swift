//
//  LoginViewModel.swift
//  MockBankingApp
//
//  Created by Damon on 17/7/21.
//

import Foundation
import CoreData

class LoginViewModel: ObservableObject {
    
    func login(username: String, context: NSManagedObjectContext) -> Bool {
        let fetchRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "username = %@ ", username)
        
        do {
            let result = try context.count(for: fetchRequest)
            if result == 0 {
                createUser(username: username, context: context)
            }
            return true
        } catch let error {
            print("Error in login. \(error)")
            return false
        }
    }
    
    func createUser(username: String, context: NSManagedObjectContext) {
        do {
            let newUser = UserEntity(context: context)
            newUser.username = username
            newUser.balance = 0
            try context.save()
        } catch let error {
            print("Error in createUser. \(error)")
        }
    }
    
}
