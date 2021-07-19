//
//  TopUpView.swift
//  MockBankingApp
//
//  Created by Damon on 17/7/21.
//

import SwiftUI

struct TopUpView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @ObservedObject var vm = TopUpViewModel()
    
    var user: UserEntity?
    
    @State private var amount = ""
    
    var body: some View {
        ZStack {
            VStack {
                TextField("Amount to top up", text: $amount)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                    .keyboardType(.numberPad)
                
                Button(action: {
                    vm.topUp(user: self.user!, amount: self.amount, context: viewContext)
                    self.mode.wrappedValue.dismiss()
                }) {
                    Text("Top Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(15.0)
                }
            }
        }
        .navigationTitle("Top Up")
    }
}

struct TopUpView_Previews: PreviewProvider {
    static var previews: some View {
        TopUpView()
    }
}
