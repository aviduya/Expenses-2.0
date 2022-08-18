//
//  GeneratorViewModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/17/22.
//

import Foundation

enum GeneratedTypes {
    case yesterday
    case thisWeek
    case thisMonth
    case lastSixMonth
    case thisYear
    case custom
    
}

final class GeneratorViewModel: ObservableObject {
    
    @Published private(set) var generatedAmount: Double = 0.0
    @Published private(set) var generatedCategory: [String] = []
    @Published private(set) var generatedPayment: [String] = []
    
    @Published var generatedEntity: [TransactionEntity] = []
    
    let dataManager: CoreDataHandler = .shared
    private var calendar = Calendar.current
    init() {
        
    }
    
    deinit {
        resetStats()
        generatedEntity = []
        print("Deinited \(generatedEntity.count)")
    }
    
    func generateReport(type: GeneratedTypes, customStart: Date?, customEnd: Date?, _ closure: () -> Void) {
        let calendar = Calendar.current
        
        var startDate = Date()
        var endDate = Date()
        
        switch type {
            
        case .yesterday:
            startDate = calendar.date(bySettingHour: 0, minute: 0, second: 1, of: Date().getYesterday() ?? Date()) ?? Date()
            endDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: startDate ) ?? Date()
        case .thisWeek:
            startDate = calendar.startOfDay(for: Date().startOfWeek())
            endDate  = calendar.date(byAdding: .day, value: 7, to: startDate) ?? Date()
        case .thisMonth:
            startDate = calendar.startOfDay(for: Date().getThisMonthStart()!)
            endDate = Date().getThisMonthEnd() ?? Date()
        case .lastSixMonth:
            startDate = Date().getLast6Month() ?? Date()
            endDate = calendar.startOfDay(for: Date())
        case .thisYear:
            startDate = calendar.date(byAdding: .month, value: -12, to: Date()) ?? Date()
            endDate = Date().getThisMonthEnd() ?? Date()
        case .custom:
            startDate = calendar.startOfDay(for: customStart ?? Date())
            endDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: customEnd ?? Date()) ?? Date()
        
        }
        
        print(startDate)
        print(endDate)
        
        dataManager.getRangeOfTransactions(start: startDate, end: endDate, &generatedEntity)
        
        closure()
        
        print(generatedEntity)
        
    }
    
    func publishReport() {
        
        for generatedContent in generatedEntity {
            generatedAmount += generatedContent.amount
            generatedCategory.append(generatedContent.category ?? "Error")
            generatedPayment.append(generatedContent.bank ?? "Error")
            
        }
        
    }
    
    func resetStats() {
        generatedAmount = 0.0
        generatedCategory = []
        generatedPayment = []
    }
    
}
