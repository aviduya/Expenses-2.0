//
//  AddTransactionsModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/29/22.
//

import Foundation

struct AddTransactionsModel {
    
    var id: UUID = UUID()
    var amount: Double?
    var name: String
    var bank: String
    var merchant: String
    var category: String
    var date: Date
    
}
