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



class AppModel: ObservableObject {
    
    @Published var banks: [BankModel] = [
        BankModel(id: "Chase", color: .blue),
        BankModel(id: "Capital One", color: .red),
        BankModel(id: "Apple", color: .white),
        BankModel(id: "Schwab", color: .teal),
        BankModel(id: "Amex", color: .orange)
    ]
    
    @Published var categories: [CategoryModel] = [
        CategoryModel(id: "Groceries", symbol: "cart"),
        CategoryModel(id: "Biils", symbol: "list.bullet.rectangle.portrait"),
        CategoryModel(id: "Personal", symbol: "person.fill"),
        CategoryModel(id: "Necesities", symbol: "person.text.rectangle.fill"),
        CategoryModel(id: "Other", symbol: "questionmark")
    ]
    
    init() {
    }
    
    
}
