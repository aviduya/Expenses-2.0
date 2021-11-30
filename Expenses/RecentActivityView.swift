//
//  RecentActivityView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/27/21.
//

import SwiftUI

struct RecentActivityView: View {
    @Environment(\.managedObjectContext) var dataModel
    @FetchRequest(sortDescriptors: []) var expenses: FetchedResults<Expense>
    var viewModel = RecentActivityViewModel()
    
    func deleteExpense(at offsets: IndexSet) {
        for index in offsets {
            let expense = expenses[index]
            dataModel.delete(expense)
        }
        do {
            try dataModel.save()
        } catch {
            print("Error has occured with CoreData")
        }
    }
        
    var body: some View {
        List {
            Section {
                ForEach(expenses) { expense in
                    RecentRowView(
                        name: expense.name ?? "Error",
                        date: viewModel.convertDate(date: expense.date ?? Date.now),
                        amount: expense.amount,
                        category: expense.category ?? "Error")
                    
                }
                .onDelete(perform: deleteExpense)
            } header: {
                HStack {
                    Image(systemName: "hourglass")
                    Text("Recent Activity")
                }
            }
            
        }

        .background {
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .foregroundColor(Color(.systemFill))
        }
    }
}
