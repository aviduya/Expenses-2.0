//
//  AppModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/29/21.
//

import Foundation
import SwiftUI

struct CategoryModel:Hashable, Identifiable {
    var id: String
    var symbol: String
}

struct BankModel: Hashable, Identifiable {
    var id: String
    var color: Color
}

enum HapticStyle {
    case light
    case medium
    case heavy
    case rigid
    
}

class AppSettings: ObservableObject {
    
    @Published var banks: [BankModel] = [
        BankModel(id: "Chase", color: .blue),
        BankModel(id: "Capital One", color: .red),
        BankModel(id: "Apple", color: .white),
        BankModel(id: "Schwab", color: .teal),
        BankModel(id: "Amex", color: .orange)
    ]
    
    @Published var categories: [CategoryModel] = [
        CategoryModel(id: "Groceries", symbol: "cart"),
        CategoryModel(id: "Bills", symbol: "list.bullet.rectangle.portrait"),
        CategoryModel(id: "Personal", symbol: "person.fill"),
        CategoryModel(id: "Necesities", symbol: "person.text.rectangle.fill"),
        CategoryModel(id: "Other", symbol: "questionmark")
    ]
    
    init() {
    }
    
    func haptic(style: HapticStyle) {
        let heavy = UIImpactFeedbackGenerator(style: .heavy)
        let soft = UIImpactFeedbackGenerator(style: .soft)
        let medium = UIImpactFeedbackGenerator(style: .medium)
        let rigid = UIImpactFeedbackGenerator(style: .rigid)
        
       
        switch style {
        case .light:
            soft.impactOccurred()
        case .medium:
            medium.impactOccurred()
        case .heavy:
            heavy.impactOccurred()
        case .rigid:
            rigid.impactOccurred()
        }
       
        
    }
    
    
}
