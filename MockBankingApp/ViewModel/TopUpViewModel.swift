//
//  TopUpViewModel.swift
//  MockBankingApp
//
//  Created by Damon on 18/7/21.
//

import Foundation
import CoreData

class TopUpViewModel: BaseViewModel {
    
    func topUp(user: UserEntity, amount: String, context: NSManagedObjectContext) {
        var topUpAmount = (amount as NSString).doubleValue
        let debtList = fetchDebtList(username: user.username!, context: context)
        
        // check if owing money to any users
        for debt in debtList {
            if debt.amount > 0 && topUpAmount > 0 {
                // deduct from topUpAmount and make payment to the creditors
                if topUpAmount > debt.amount {
                    topUpAmount -= debt.amount
                    super.pay(from: user.username!, to: debt.oweTo!, amount: String(format: "%.0f", debt.amount), context: context)
                } else {
                    super.pay(from: user.username!, to: debt.oweTo!, amount: String(format: "%.0f", topUpAmount), context: context)
                    topUpAmount = 0
                }
            }
        }
        
        //
        if topUpAmount > 0 {
            user.balance += topUpAmount
        }
        super.saveData(context: context)
    }
    
    func fetchDebtList(username: String, context: NSManagedObjectContext) -> [DebtEntity] {
        let fetchRequest = NSFetchRequest<DebtEntity>(entityName: "DebtEntity")
        fetchRequest.predicate = NSPredicate(format: "username = %@ ", username)
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error {
            print("Error in fetchOwingTo. \(error)")
            return []
        }
    }
    
}
