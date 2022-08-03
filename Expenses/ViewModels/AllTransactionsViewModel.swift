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
    
    enum selectedFilter: Hashable {
         case today
         case seven
         case month
         case year
     }
    
    var filter = selectedFilter.self
    
    var status: String {
        
        switch page {
        case .today:
            return "Today"
        case .seven:
            return "7 Days"
        case .month:
            return "Month"
        case .year:
            return "All"
        }
    }
    
    func monthDay(input: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, YY"
        let dayInWeek = dateFormatter.string(from: input)
        
        return dayInWeek
    }
}


