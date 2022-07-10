//
//  HomeViewModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/14/22.
//

import Foundation
import UIKit

class HomeViewModel: ObservableObject {
    
    //TODO: Have Dispatchque allocated to main thread when refactoring dataHandler for HomeView()
    
    let dataManager = CoreDataHandler.shared
    
    
    
    init() {
      
    }
    
    var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        let newDay = 0
        let noon = 12
        let sunset = 18
        let midnight = 24
        
        var message = ""
        switch hour {
            
        case newDay ..< noon:
            message = "Good Morning!"
        case noon ..< sunset:
            message = "Good Afternoon!"
        case sunset ..< midnight:
            message = "Good Evening!"
            
        default:
            message = "Hello!"
        }
        
        return message
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

