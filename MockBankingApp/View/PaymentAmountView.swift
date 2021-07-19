//
//  PaymentAmountView.swift
//  MockBankingApp
//
//  Created by Damon on 18/7/21.
//

import SwiftUI

struct PaymentAmountView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    @StateObject var vm = BaseViewModel()
    @State var payAmount: String = ""
    var from: String = ""
    var to: String = ""
    
    var body: some View {
        VStack {
            TextField("Pay amount", text:self.$payAmount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .keyboardType(.numberPad)
            
            Button(action: {
                vm.pay(from: from, to: to, amount: self.payAmount, context: viewContext)
                self.mode.wrappedValue.dismiss()
                self.mode.wrappedValue.dismiss()
            }) {
                Text("Pay")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
        }
        .navigationTitle("Pay")
    }
}

struct PaymentAmountView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentAmountView()
    }
}
