//
//  HomeViewModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/14/22.
//

import Foundation
import UIKit


enum ActiveView: Identifiable {
    
    case settings
    case add
    case all
    
    var id: Int {
        hashValue
    }
    
}

class HomeViewModel: ObservableObject {
    
   
    
    @Published var greeting: String = "Hello!"
    
    init() {
        computedGreeting()
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

