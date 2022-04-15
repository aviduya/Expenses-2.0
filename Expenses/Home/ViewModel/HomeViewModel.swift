//
//  HomeViewModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/14/22.
//

import Foundation
import UIKit


class HomeViewModel: ObservableObject {
    
    @Published var greeting: String = "Hello!"
    @Published var spentToday: Double = 0.0
    @Published var topCategory: String = ""
    @Published var topPayment: String = ""
    
    init() {
        computedGreeting()
        runAllComp()
        
        print(runAllComp())
    }
    
    
    func runAllComp() {
        computedSpent()
        computedCat()
        computedPay()
        
    }
    
    
    func computedSpent() {
        let data = CoreDataHandler()
        var totalAmount = 0.0
        
        for savedAmount in data.savedEntities {
            totalAmount += savedAmount.amount
        }
        
        spentToday = totalAmount
    }
    
    func computedCat() {
        let data = CoreDataHandler()
        
        var topCat: [String] {
            var arry: [String] = []
            
            for cat in data.savedEntities {
               arry.append(cat.category ?? "Error")
            }
            
            return arry.filtered()
        }
        topCategory = topCat.first ?? "Error"
    }
    
    func computedPay() {
        let data = CoreDataHandler()
        
        var topPay: [String] {
             var arry: [String] = []
            
            for pay in data.savedEntities {
                arry.append(pay.bank ?? "Error")
            }
            
            return arry.filtered()
        }
        topPayment = topPay.first ?? "Error"
    }
    
    
    func computedGreeting() {
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
        
        greeting = message
    }
    
}

extension Array where Element: Equatable {

    func filtered() -> [Element] {
        let countedSet = NSCountedSet(array: self)
        let mostPopularElement = self.max { countedSet.count(for: $0) < countedSet.count(for: $1) }
        return self.filter { $0 == mostPopularElement }
    }

}
