//
//  HomeViewModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/14/22.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    
    @Published var homeMessage: String = ""
    
    @Published var allTransactions: [TransactionEntity] = [] {
        didSet {
            calculateWidgets()
        }
    }
    
    @Published var todayTransactions: Double = 0.0
    @Published var differenceMessage: LocalizedStringKey = ""
    @Published var hasNegative: Bool = false
    
    private var yesterdayTransaction: Double = 0.0
    private let dataManager = CoreDataHandler.shared
    

    init() {
        
        dataManager.getTransaction(&allTransactions)
        generateMessage()
      
    }
    
    func generateMessage() {
        
        let hour = Calendar.current.component(.hour, from: Date())
        let newDay = 0
        let noon = 12
        let sunset = 18
        let midnight = 24
        
        switch hour {
            
        case newDay ..< noon:
            homeMessage = "Good Morning!"
        case noon ..< sunset:
            homeMessage = "Good Afternoon!"
        case sunset ..< midnight:
            homeMessage = "Good Evening!"
            
        default:
            homeMessage = "Hello!"
        }
        
    }
    
    func calculateWidgets() {
        
        let calendar = Calendar.current
        var differenceSpendingValue: Double = 0.0
    
        for transaction in allTransactions {
            if calendar.isDateInToday(transaction.date ?? Date()) {
                todayTransactions += transaction.amount
            }
            
            if calendar.isDateInYesterday(transaction.date ?? Date()) {
                yesterdayTransaction += transaction.amount
            }
        }
        
        differenceSpendingValue = todayTransactions - yesterdayTransaction

        if differenceSpendingValue.sign == .minus {
            hasNegative = true
   
            differenceMessage = "- $\(abs(differenceSpendingValue.rounded()), specifier: "%.2f")"
        } else {
            differenceMessage = "+ $\(differenceSpendingValue.rounded(), specifier: "%.2f")"
        }
        
        
        
        
        print(todayTransactions) 
        
        
    }
    
    var spentToday: Double {
        
        var total = 0.0
        
        for transaction in dataManager.today {
            total += transaction.amount
        }
        
        return total
    }
    
    var spentYesterday: Double {
        
        var total = 0.0
        
        if dataManager.yesterday.isEmpty {
            total = 1.0
        } else {
            for transaction in dataManager.yesterday {
                total += transaction.amount
            }
        }
        return total
    }
    
    var diffPercentage: Double {
        let difference = spentToday - spentYesterday
        if dataManager.yesterday.isEmpty && dataManager.today.isEmpty {
            return 0.0
        } else {
            return (difference / spentYesterday) * 100.099
            
        }
    }
    
    var topCat: String {
        var arry: [String] = []
        
        for transaction in dataManager.all {
            arry.append(transaction.category ?? "")
            
        }
        
        return arry.filtered().first ?? "No Category Recorded"
    }
    
    var topPayment: String {
        var arry: [String] = []
        
        for transaction in dataManager.all {
            arry.append(transaction.bank ?? "")
        }
        
        return arry.filtered().first ?? "No Payment Recorded"
    }
}

