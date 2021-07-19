//
//  LoginView.swift
//  MockBankingApp
//
//  Created by Damon on 17/7/21.
//

import SwiftUI
import CoreData

struct LoginView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var vm = LoginViewModel()
    
    @State private var currentUsername: String = ""
    @State private var isLoggedIn: Bool = false
    
    var body: some View {
        VStack {
            TextField("Username", text: $currentUsername)
                .disableAutocorrection(true)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                if !self.currentUsername.isEmpty {
                    self.isLoggedIn = vm.login(username: currentUsername, context: viewContext)
                }
            }) {
                Text("Login")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
            
            NavigationLink(destination: DashboardView(currentUsername: currentUsername), isActive: $isLoggedIn) {
                EmptyView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
