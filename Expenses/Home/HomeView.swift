//
//  HomeView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/8/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var isPresented: Bool = false
    @ObservedObject var vm = HomeViewModel()
    @StateObject var dataManager = CoreDataHandler()
    
    var body: some View {
        NavigationView {
            
            VStack(spacing: 20) {
                HomeSummary
                    .padding(.leading, 25)

                transactionsList
                
            }
            
            .navigationTitle(vm.greeting)
            .toolbar {
                EditButton()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isPresented.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
        
        .sheet(isPresented: $isPresented, onDismiss: { dataManager.fetchTransactions() }) {
            AddTransactionView()
        }
    }
    
}
