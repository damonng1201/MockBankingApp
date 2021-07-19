//
//  DashboardViewModel.swift
//  MockBankingApp
//
//  Created by Damon on 17/7/21.
//

import Foundation
import CoreData

class DashboardViewModel: ObservableObject {
    
    @Published var users: [UserEntity] = []
    @Published var transactions: [TransactionEntity] = []
    @Published var owingTo: [DebtEntity] = []
    @Published var owingFrom: [DebtEntity] = []
    
    func fetchUser(username: String, context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "username = %@ ", username)
        
        do {
            users = try context.fetch(fetchRequest)
        } catch let error {
            print("Error in fetchUser. \(error)")
        }
    }
    
    func fetchTransactions(username: String, context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "transactionDate", ascending: false)]
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "username = %@ ", username)
        
        do {
            transactions = try context.fetch(fetchRequest)
        } catch let error {
            print("Error in fetchTransactions. \(error)")
        }
    }
    
    func fetchOwingTo(username: String, context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<DebtEntity>(entityName: "DebtEntity")
        fetchRequest.predicate = NSPredicate(format: "username = %@ ", username)
        
        do {
            owingTo = try context.fetch(fetchRequest)
        } catch let error {
            print("Error in fetchOwingTo. \(error)")
        }
    }
    
    func fetchOwingFrom(username: String, context: NSManagedObjectContext) {
        let fetchRequest = NSFetchRequest<DebtEntity>(entityName: "DebtEntity")
        fetchRequest.predicate = NSPredicate(format: "oweTo = %@ ", username)
        
        do {
            owingFrom = try context.fetch(fetchRequest)
        } catch let error {
            print("Error in fetchOwingFrom. \(error)")
        }
    }
    
}
