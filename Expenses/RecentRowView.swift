//
//  RecentRowView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/28/21.
//

import SwiftUI

//let categories = ["Groceries", "Bills", "Personal", "Other", "Necesities"]
 private enum TypeSymbols {
    case groceries
    case bills
    case personal
    case other
    case necesities
}

struct RecentRowView: View {
    var name: String
    var date: String
    var amount: Double
    var image: String
    
    func symbol() -> String {
        
    }
    
    var body: some View {
        HStack {
            
        }
    }
}
