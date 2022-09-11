//
//  HomeViewModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/14/22.
//

import Foundation
import SwiftUI
import CoreLocation
import MapKit

class HomeViewModel: ObservableObject {
    
    @Published var homeMessage: String = ""
    @Published var todayTransactions: Double = 0.0
    @Published var differenceMessage: LocalizedStringKey = ""
    @Published var mostUsedCategory: String = ""
    @Published var mostUsedPayment: String = ""
    @Published var hasNegative: Bool = false
    
    @Published var allTransactions: [TransactionEntity] = [] {
        didSet {
            calculateWidgets()
            print("Loaded \(allTransactions.count) Transactions Onto HomeView() ")
            
        }
    }
    
    private var yesterdayTransaction: Double = 0.0
    private let dataManager = CoreDataHandler.shared
    
    init() {
        
        dataManager.getTransaction(&allTransactions, debugStatement: "HomeViewModel , Line 35")
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
        var mostFrequentPayment: [String] = []
        var mostFrequentCategory: [String] = []
        
        // MARK: Calculate the spending amount
        
        for transaction in allTransactions {
            if calendar.isDateInToday(transaction.date ?? Date()) {
                todayTransactions += transaction.amount
            }
            
            if calendar.isDateInYesterday(transaction.date ?? Date()) {
                yesterdayTransaction += transaction.amount
            }
            
            mostFrequentPayment.append(transaction.category ?? "Error")
            mostFrequentCategory.append(transaction.bank ?? "Error")
            
        }
        
        differenceSpendingValue = todayTransactions - yesterdayTransaction
        
        if differenceSpendingValue.sign == .minus {
            hasNegative = true
            
            differenceMessage = "- $\(abs(differenceSpendingValue.rounded()), specifier: "%.2f")"
        } else {
            differenceMessage = "+ $\(differenceSpendingValue.rounded(), specifier: "%.2f")"
        }
        
        // MARK: Calculate the most used items
        
        mostUsedCategory = mostFrequentCategory.filtered().first ?? "None"
        mostUsedPayment = mostFrequentPayment.filtered().first ?? "None"
            
    }
}

