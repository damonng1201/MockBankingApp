//
//  PayeeListViewModel.swift
//  MockBankingApp
//
//  Created by Damon on 18/7/21.
//

import Foundation
import CoreData

class PayeeListViewModel: ObservableObject {
    
    @Published var payeeList: [UserEntity] = []
    
    func fetchPayeeList(username: String, context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        fetchRequest.predicate = NSPredicate(format: "username != %@ ", username)
        
        do {
            payeeList = try context.fetch(fetchRequest)
        } catch let error {
            print("Error in fetchUser. \(error)")
        }
    }
    
}
