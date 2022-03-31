//
//  ExpensesApp.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/24/21.
//

import SwiftUI

@main
struct ExpensesApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            
            AddTransactionView()
            
//            ContentView()
//                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
