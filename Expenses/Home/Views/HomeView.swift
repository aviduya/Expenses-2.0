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
    @StateObject var dm = CoreDataHandler.shared
    
    var body: some View {
        NavigationView {
            VStack {
                HomeSummary
                    .padding(.leading)
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
        .onAppear(perform: dm.fetchTransactions)
        .sheet(isPresented: $isPresented, onDismiss: { dm.fetchTransactions() }) {
            AddTransactionView()
        }
    }
    
}
