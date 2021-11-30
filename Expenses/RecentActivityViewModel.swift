//
//  RecentActivityViewModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/29/21.
//

import Foundation

class RecentActivityViewModel {
    
    func convertDate(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, YY"
        
        return formatter.string(from: date)
    }

}
