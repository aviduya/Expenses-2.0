//
//  ContentView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/24/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showingAddExpense = false
    @StateObject var core = CoreDataHandler()
    var body: some View {
        
        NavigationView {
            
            VStack {
//                HomeSummaryView()
                
                List(core.savedEntities) { entity in
                    Text("\(entity.amount)")
                }

            }
            .navigationTitle(greeting)
            .toolbar {
                EditButton()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddExpense.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddTransactionView()
        }
    }

    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        let newDay = 0
        let noon = 12
        let sunset = 18
        let midnight = 24
        
        var greeting = ""
        
        switch hour {
            
        case newDay ..< noon:
            greeting = "Good Morning!"
        case noon ..< sunset:
            greeting = "Good Afternoon!"
        case sunset ..< midnight:
            greeting = "Good Evening!"
            
        default:
            greeting = "Hello!"
        }
        
        return greeting
        
    }
    
}

