//
//  DashboardView.swift
//  MockBankingApp
//
//  Created by Damon on 17/7/21.
//

import SwiftUI

struct DashboardView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var vm = DashboardViewModel()
    var currentUsername: String
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(vm.users) { entity in
                    Text("Hello, \(entity.username ?? "")!")
                    ForEach(vm.transactions) { transactionEntity in
                        Text("Transferred \(transactionEntity.amount, specifier: "%.0f") to \(transactionEntity.transferTo ?? "")")
                    }
                    ForEach(vm.owingFrom) { debtEntity in
                        Text("Owing \(debtEntity.amount, specifier: "%.0f") from \(debtEntity.username ?? "")")
                    }
                    Text("Your balance is \(entity.balance , specifier: "%.0f").")
                    ForEach(vm.owingTo) { debtEntity in
                        Text("Owing \(debtEntity.amount, specifier: "%.0f") to \(debtEntity.oweTo ?? "")")
                    }
                    HStack {
                        NavigationLink(destination: TopUpView(user: entity), label: {
                            Text("Top Up")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(15.0)
                        })
                        
                        NavigationLink(destination: PayeeListView(currentUsername: currentUsername), label: {
                            Text("Pay")
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(15.0)
                        })
                    }
                }
            }
        }
        .navigationTitle("Dashboard")
        .onAppear(perform: {
            vm.fetchUser(username: currentUsername, context: viewContext)
            vm.fetchTransactions(username: currentUsername, context: viewContext)
            vm.fetchOwingFrom(username: currentUsername, context: viewContext)
            vm.fetchOwingTo(username: currentUsername, context: viewContext)
        })
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(currentUsername: "Jack")
    }
}
