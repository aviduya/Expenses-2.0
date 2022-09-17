//
//  AllTransactionsWeekViewModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 9/10/22.
//

import Foundation

class AllTransactionsWeekViewModel: ObservableObject {
    let dataManager: CoreDataHandler = .shared
    @Published var TransactionsList: [AllTransactionsWeekModel] = []
    
    init() {
        generateTransactionsList()
    }
    
    func generateTransactionsList() {
        let calendar = Calendar.current
        
        let dateNow = calendar.startOfDay(for: Date.now)
        
        let nameDateFormatter = DateFormatter()
        let dayDateFormatter = DateFormatter()
        nameDateFormatter.dateFormat = "EEEE"
        dayDateFormatter.dateFormat = "d"
        
        var days: [Date] = []
        
        for x in 0...6 {
            days.append(calendar.date(byAdding: .day, value: -x, to: dateNow) ?? Date())
        }
        
        for day in days {
            TransactionsList.append(
                AllTransactionsWeekModel(
                    dayName: nameDateFormatter.string(from: day),
                    dayNumber: dayDateFormatter.string(from: day),
                    savedDate: day,
                    entities: dataManager.getRangeOfTransactionsExample(start: calendar.startOfDay(for: day), end: calendar.date(bySettingHour: 23, minute: 59, second: 59, of: day) ?? Date())))
        }

    }
    

}
