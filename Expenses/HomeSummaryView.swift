//
//  HomeSummaryView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/24/22.
//

import SwiftUI
import Foundation

struct HomeSummaryView: View {
    
    @Environment(\.managedObjectContext) var dataModel
    @FetchRequest(sortDescriptors: []) var expenses: FetchedResults<Expense>
    
    
    //A Computed property that calculate the total from the purchases 
    var spentToday: Double {
        var total = 0.0
        
        for expense in expenses {
            total += expense.amount
        }
        
        return total
    }
    
    //A Computed property that appends to an empty array from CoreData which filters most exisiting element.
    var topCategory: [String] {
        let expenseCategory = expenses
        var topExpense: [String] = []
        for expense in expenseCategory {
            topExpense.append(expense.category ?? "Error")
        }
        
        return topExpense.filtered()
        
    }
    
    //A Computed property that appends to an empty array from CoreData which filters most exisiting element.
    var topPayment: [String] {
        let expensePayment = expenses
        var topPayment: [String] = []
        
        for expense in expensePayment {
            topPayment.append(expense.bank ?? "Error")
        }
        
        return topPayment.filtered()
    }
    
    

    @State var mostUsedPayment: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
    
            
            VStack(alignment: .leading) {
                Text("Spent Today")
                    .font(.system(size: 30, weight: .regular, design: .default))
                    .opacity(0.5)
                Text("$\(spentToday, specifier: "%.2f")")
                    .font(.system(size: 35, weight: .regular, design: .rounded))
            }
            VStack(alignment: .leading) {
                Text("Top Category")
                    .font(.headline)
                    .opacity(0.5)
                Text(topCategory.first ?? "Error")
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
            VStack(alignment: .leading) {
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text(topPayment.first ?? "Error")
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .clipped()
        .padding(.leading, 30.0)
        
    }
}



extension Array where Element: Equatable {
    
    func filtered() -> [Element] {
        let countedSet = NSCountedSet(array: self)
        let mostPopularElement = self.max { countedSet.count(for: $0) < countedSet.count(for: $1) }
        return self.filter { $0 == mostPopularElement }
    }
    
}
