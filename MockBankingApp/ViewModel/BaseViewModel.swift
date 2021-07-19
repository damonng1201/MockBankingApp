//
//  BaseViewModel.swift
//  MockBankingApp
//
//  Created by Damon on 18/7/21.
//

import Foundation
import CoreData

class BaseViewModel: ObservableObject {
    
    func fetchUserByUsername(username: String, context: NSManagedObjectContext) -> UserEntity {
        let fetchRequest = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "username = %@ ", username)
        
        do {
            let users = try context.fetch(fetchRequest)
            return users[0]
        } catch let error {
            print("Error in fetchUserByUsername. \(error)")
            return UserEntity(context: context)
        }
    }
    
    func fetchOwingTo(username: String, context: NSManagedObjectContext) -> DebtEntity {
        let fetchRequest = NSFetchRequest<DebtEntity>(entityName: "DebtEntity")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "username = %@ ", username)
        
        do {
            let result = try context.fetch(fetchRequest)
            if result.count == 1 {
                return result[0]
            }
        } catch let error {
            print("Error in fetchOwingTo. \(error)")
        }
        return DebtEntity(context: context)
    }
    
    func fetchOwingFrom(username: String, context: NSManagedObjectContext) -> DebtEntity {
        let fetchRequest = NSFetchRequest<DebtEntity>(entityName: "DebtEntity")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "oweTo = %@ ", username)
        
        do {
            let result = try context.fetch(fetchRequest)
            if result.count == 1 {
                return result[0]
            }
        } catch let error {
            print("Error in fetchOwingFrom. \(error)")
        }
        return DebtEntity(context: context)
    }
    
    func saveData(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch let error {
            print("Error in updateData. \(error)")
        }
    }
    
    func deleteDebt(debtEntity: DebtEntity, context: NSManagedObjectContext) {
        context.delete(debtEntity)
    }
    
    func saveTransaction(from: String, to: String, amount: Double, context: NSManagedObjectContext) {
        do {
            let newTransaction = TransactionEntity(context: context)
            newTransaction.username = from
            newTransaction.transferTo = to
            newTransaction.amount = amount
            newTransaction.transactionDate = Date()
            try context.save()
        } catch let error {
            print("Error in saveTransaction. \(error)")
        }
    }
    
    func pay(from: String, to: String, amount: String, context: NSManagedObjectContext) {
        var payAmount = (amount as NSString).doubleValue
        let fromUser = fetchUserByUsername(username: from, context: context)
        let toUser = fetchUserByUsername(username: to, context: context)
        let owingTo = fetchOwingTo(username: to, context: context)
        let owingFrom = fetchOwingFrom(username: to, context: context)
        
        // check if still owing money to the payee
        if owingTo.amount > 0 {
            if payAmount > owingTo.amount {
                payAmount -= owingTo.amount
                owingTo.amount = 0
                // delete debt record once the debt has cleared
                deleteDebt(debtEntity: owingTo, context: context)
            } else {
                owingTo.amount -= payAmount
                payAmount = 0
                // delete debt record once the debt has cleared
                if owingTo.amount == 0 {
                    deleteDebt(debtEntity: owingTo, context: context)
                }
            }
            // update all the records changes in CoreData
            saveData(context: context)
        }
        
        // check if payee owing money
        if owingFrom.amount > 0 {
            if payAmount > owingFrom.amount {
                payAmount -= owingFrom.amount
                owingFrom.amount = 0
                // delete debt record once the debt has cleared
                deleteDebt(debtEntity: owingFrom, context: context)
            } else {
                owingFrom.amount -= payAmount
                toUser.balance += payAmount
                saveTransaction(from: from, to: to, amount: payAmount, context: context)
                payAmount = 0
                // delete debt record once the debt has cleared
                if owingFrom.amount == 0 {
                    deleteDebt(debtEntity: owingFrom, context: context)
                }
            }
            // update all the records changes in CoreData
            saveData(context: context)
        }
        
        if payAmount > 0 {
            if fromUser.balance >= payAmount {
                fromUser.balance -= payAmount
                toUser.balance += payAmount
            } else {
                // create new debt record if account balance is insufficient for payment
                let newDebt = DebtEntity(context: context)
                newDebt.username = from
                newDebt.oweTo = to
                newDebt.amount = payAmount - fromUser.balance
                payAmount = fromUser.balance
                fromUser.balance = 0
                toUser.balance += payAmount
            }
            // update all the records changes in CoreData
            saveData(context: context)
            saveTransaction(from: from, to: to, amount: payAmount, context: context)
        }
    }
    
}
