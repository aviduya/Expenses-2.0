//
//  AppModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/29/21.
//

import Foundation

enum Banks: String, CaseIterable, Identifiable  {
    var id: String {self.rawValue}
    
    case chase = "Chase"
    case capitalone = "Capital One"
    case apple = "Apple Card"
    case schwab = "Charles Schwab"
    case amex = "American Express"
}

enum Categories: String, CaseIterable, Identifiable {
    var id: String {self.rawValue}
    
    case groceries = "Groceries"
    case bills = "Bills"
    case personal = "Personal"
    case other = "Necesities"
    case necesities = "Other"
    
}

enum Types: String, CaseIterable, Identifiable {
    var id: String{self.rawValue}
    
    case online = "Online"
    case inperson = "In-Person"
}

enum CategorySymbols: String  {
    case groceries = "cart"
    case bills = "list.bullet.rectangle.portrait"
    case personal = "person.fill"
    case other = "questionmark"
    case necesities = "person.text.rectangle.fill"
}

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}
