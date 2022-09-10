//
//  AllTransactionsModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 9/10/22.
//

import Foundation

struct AllTransactionsWeekModel: Identifiable {
    let id = UUID().uuidString
    var dayName: String
    var dayNumber: String
    var savedDate: Date
    var entities: [TransactionEntity]
    
    init(dayName: String, dayNumber: String, savedDate: Date, entities: [TransactionEntity]) {
        
        self.dayName = String(dayName.first ?? "E")
        self.dayNumber = dayNumber
        self.savedDate = Calendar.current.startOfDay(for: savedDate)
        self.entities = entities
    }
}
