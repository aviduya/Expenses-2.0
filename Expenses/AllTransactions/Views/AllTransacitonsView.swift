//
//  AllTransacitonsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/21/22.
//

import SwiftUI
import Expenses_UI_Library

struct AllTransacitonsView: View {
    
    @StateObject var dataManager = AllTransactionsViewModel()
    @ObservedObject var vm = AllTransactionsViewModel()
    
    var body: some View {
        
        NavigationView {
            List {
                Section {
                    ForEach(dataManager.today) { data in
                        RecentRowView(
                            item: data.name ?? "",
                            date: vm.convertDate(date: data.date ?? Date()),
                            amount: data.amount ,
                            category: data.category ?? "")
                    }
                    
                } header: {
                        Text("Today's")
                } footer: {
                    HStack {
                        Text("\(dataManager.today.count) Transactions")
                    }
                }
                
                Section {
                    ForEach(dataManager.week) { data in
                        RecentRowView(
                            item: data.name ?? "",
                            date: vm.convertDate(date: data.date ?? Date()),
                            amount: data.amount ,
                            category: data.category ?? "")
                    }
                    
                } header: {
                        Text("This Week")
                } footer: {
                    HStack {
                        Text("\(dataManager.week.count) Transactions")
                    }
                }
                
            }
        }
        .navigationTitle("All Tranactions")
        
    }
}


