//
//  AllTransactionsVM.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/21/22.
//

import Foundation
import CoreData



class AllTransactionsViewModel: ObservableObject {
    
    @Published var page: selectedFilter = .today
    @Published var startDate: Date = Date()
    @Published var endDate: Date = Date()
    @Published var rangeOfTransactions: [TransactionEntity] = []
    
    let dataManager = CoreDataHandler.shared
        
    enum selectedFilter: Hashable {
         case today
         case seven
         case month
         case custom
     }
    
    func runRangeRequest() {
        
        let calendar = Calendar.current
        
        dataManager.getRangeOfTransactions(start: startDate, end: endDate, &rangeOfTransactions)
        
        print(calendar.startOfDay(for: Date()))
    }
    
    var filter = selectedFilter.self
    
    var status: String {
        
        switch page {
        case .today:
            return "Today"
        case .seven:
            return "Last 7 Days"
        case .month:
            return "Current Month"
        case .custom:
            return "Custom"
        }
    }
    
    func monthDay(input: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, YY"
        let dayInWeek = dateFormatter.string(from: input)
        
        return dayInWeek
    }
}


