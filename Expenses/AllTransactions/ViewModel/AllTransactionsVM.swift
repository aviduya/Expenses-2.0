//
//  AllTransactionsVM.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/21/22.
//

import Foundation
import CoreData


enum selectedFilter: Hashable {
     case today
     case seven
     case month
     case year
 }

class AllTransactionsViewModel: ObservableObject {
    
    @Published var page: selectedFilter = .today
    
    var status: String {
        
        switch page {
        case .today:
            return "Today's Transactions"
        case .seven:
            return "Last 7 Days"
        case .month:
            return "This Month"
        case .year:
            return "All Transactions"
            
        }
        
    }

    func convertDate(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, YY"
        
        return formatter.string(from: date)
    }
}


