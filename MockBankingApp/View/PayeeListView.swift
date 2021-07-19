//
//  PayeeListView.swift
//  MockBankingApp
//
//  Created by Damon on 18/7/21.
//

import SwiftUI

struct PayeeListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @StateObject var vm = PayeeListViewModel()
    var currentUsername: String
    
    var body: some View {
        List {
            ForEach(vm.payeeList, id:\.self) { user in
                NavigationLink(
                    destination: PaymentAmountView(from: currentUsername, to: user.username!),
                    label: {
                        Text(user.username ?? "")
                    })
            }
        }
        .navigationTitle("Transfer to")
        .onAppear(perform: {
            vm.fetchPayeeList(username: currentUsername, context: viewContext)
        })
    }
}

struct PayeeListView_Previews: PreviewProvider {
    static var previews: some View {
        PayeeListView(currentUsername: "Jack")
    }
}
