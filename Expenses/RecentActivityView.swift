//
//  RecentActivityView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/27/21.
//

import SwiftUI

struct RecentActivityView: View {

    @StateObject var core = CoreDataHandler()
    
    var viewModel = RecentActivityViewModel()
        
    var body: some View {
            Section {
                ForEach(core.savedEntities) { transactions in
                    RecentRowView(
                        name: transactions.name ?? "Error",
                        date: viewModel.convertDate(date: transactions.date ?? Date.now),
                        amount: transactions.amount,
                        category: transactions.category ?? "Error")
                    
                }
                .onDelete(perform: core.deleteTransactions)
            } header: {
                HStack {
                    Text("Recent Transactions")
                    Spacer()
                }
            }

    }
}
