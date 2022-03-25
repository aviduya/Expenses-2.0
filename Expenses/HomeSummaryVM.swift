//
//  HomeSummaryVM.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/25/22.
//

import Foundation
import SwiftUI

class HomeSummaryViewModel {
    @FetchRequest(sortDescriptors: []) var expenses: FetchedResults<Expense>
        
    var spentToday: Double {
        var total = 0.0
        
        for expense in expenses {
            total += expense.amount
        }
        
        return total
    }
    
    var topCategory: [String] {
        let expenseCategory = expenses
        var topExpense: [String] = []
        for expense in expenseCategory {
            topExpense.append(expense.category ?? "Error")
        }
        
        return topExpense.filtered()
        
    }
    
    
    var topPayment: [String] {
        let expensePayment = expenses
        var topPayment: [String] = []
        
        for expense in expensePayment {
            topPayment.append(expense.bank ?? "Error")
        }
        
        return topPayment.filtered()
    }
    
    
}
