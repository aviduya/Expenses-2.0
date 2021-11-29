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
    
    //TODO: Tired, need to format date to proper string to show in recent view.
    

    func convertDate(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, YY"
        
        return formatter.string(from: date)
    }
        
        
    var body: some View {
        List {
            Section {
                ForEach(expenses) { expense in
                    HStack {
                        if let name = expense.name {
                            Text(name)
                        }
                        Spacer()
                        Text("$\(expense.amount, specifier: "%.2f")")
                            .opacity(0.5)
                        if let expenseDate = expense.date {
                            Text(convertDate(date: expenseDate))
                        }
                    }
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

struct RecentActivityView_Previews: PreviewProvider {
    static var previews: some View {
        RecentActivityView()
    }
}
