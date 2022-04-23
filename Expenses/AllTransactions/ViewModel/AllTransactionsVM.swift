//
//  AllTransactionsVM.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/21/22.
//

import Foundation
import CoreData


class AllTransactionsViewModel: ObservableObject {

    func convertDate(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, YY"
        
        return formatter.string(from: date)
    }
}


