//
//  ContentView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/24/21.
//

import SwiftUI

struct ContentView: View {
    @State private var showingAddExpense = false
    
    
    
    var body: some View {
        NavigationView {
            RecentActivityView()
                .navigationTitle("Expenses")
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
            AddExpenseView()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
