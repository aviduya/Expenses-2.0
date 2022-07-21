//
//  AddTransactionsVM.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/29/22.
//

import Foundation
import CoreData
import UIKit

class AddTransactionsViewModel: ObservableObject {
    
    func save(amount: Double, name: String, merchant: String, _ comlpletion1: () -> (), _ completion2: () ->()) {
        
        let generator = UINotificationFeedbackGenerator()
        let a = amount
        let n = name
        let m = merchant
        
        
        if a == 0.0 || n.isEmpty || m.isEmpty {
                generator.notificationOccurred(.error)
               comlpletion1()
            } else {
                completion2()
                generator.notificationOccurred(.success)
            }
        
        
    }
    
}
