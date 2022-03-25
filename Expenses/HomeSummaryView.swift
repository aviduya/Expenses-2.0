//
//  HomeSummaryView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/24/22.
//

import SwiftUI

struct HomeSummaryView: View {
    
    @Environment(\.managedObjectContext) var dataModel
    @FetchRequest(sortDescriptors: []) var expenses: FetchedResults<Expense>
    
    var spentToday: Double {
        var total = 0.0
        
        for expense in expenses {
            total += expense.amount
        }
        return total
    }
    
    @State var topCategory: String
    @State var mostUsedPayment: String
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
    
            
            VStack(alignment: .leading) {
                Text("Spent Today")
                    .font(.system(size: 30, weight: .regular, design: .default))
                    .opacity(0.5)
                Text("$\(spentToday, specifier: "%.2f")")
                    .font(.system(size: 35, weight: .regular, design: .rounded))
            }
            VStack(alignment: .leading) {
                Text("Top Category")
                    .font(.headline)
                    .opacity(0.5)
                Text(topCategory)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
            VStack(alignment: .leading) {
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text(mostUsedPayment)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .clipped()
        .padding(.leading, 30.0)
        
    }
}

