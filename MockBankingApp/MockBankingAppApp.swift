//
//  MockBankingAppApp.swift
//  MockBankingApp
//
//  Created by Damon on 17/7/21.
//  added some comments

import SwiftUI

@main
struct MockBankingAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
