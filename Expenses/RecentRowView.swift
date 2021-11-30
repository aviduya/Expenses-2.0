//
//  RecentRowView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/28/21.
//

import SwiftUI

struct RecentRowView: View {
    var name: String
    var date: String
    var amount: Double
    var category: String

    func convertSymbols(_ category: String) -> String {
        
        let s = CategorySymbols.self
        
        switch category.lowercased() {
        case "groceries":
            return s.groceries.rawValue
        case "bills":
            return s.bills.rawValue
        case "personal":
            return s.personal.rawValue
        case "other":
            return s.other.rawValue
        case "necesities":
            return s.necesities.rawValue
        default:
            return "xmark.diamond"
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: convertSymbols(category))
            VStack(alignment: .leading) {
                Text(name)
                Text(date)
                    .opacity(0.5)
            }
            Spacer()
            Text("$\(amount, specifier: "%.2f")")
        }
    }
}
