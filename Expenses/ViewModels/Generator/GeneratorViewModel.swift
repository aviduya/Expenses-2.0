//
//  GeneratorViewModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/17/22.
//

import Foundation

class GeneratorViewModel: ObservableObject {
    
    @Published private(set) var generatedAmount: Double = 0.0
    @Published private(set) var generatedCategory: String = ""
    @Published private(set) var generatedPayment: String = ""
    
    @Published var generatedWeek: [TransactionEntity] = []
    
    let dataManager: CoreDataHandler = .shared
    private var calendar = Calendar.current
    init() {
        

        let weekDateFrom = calendar.startOfDay(for: Date().startOfWeek())
        let weekDateTo = calendar.date(byAdding: .day, value: 7,  to: weekDateFrom) ?? Date()
        
        dataManager.getRangeOfTransactions(start: weekDateFrom, end: weekDateTo, &generatedWeek)
        
        print("New Feature: \(generatedWeek.count)")
    }
    
    deinit {
        generatedWeek = []
        print("Deinited \(generatedWeek.count)")
    }
    
    func generateWeekReport() {
        
        for total in generatedWeek {
            generatedAmount += total.amount
        }
        
    }
    
}
