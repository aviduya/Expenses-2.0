//
//  HomeExtensions.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/14/22.
//

import Foundation
import SwiftUI

//MARK: Extracted Views of HomeView

extension HomeView {
    
    var transactionsList: some View {
        List {
            ForEach(dataManager.savedEntities) { data in
                Text("\(data.amount)")
            }
            .onDelete(perform: dataManager.deleteTransactions)
            
        }
        
    }
    
    var HomeSummary: some View {
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
                Text(topCat)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
            VStack(alignment: .leading) {
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text(topPayment)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .clipped()
        .padding(.leading, 30.0)
    }
}

//MARK: Computed Properties returning data. 

extension HomeView {
    
    var spentToday: Double {
        var total = 0.0
        
        for transaction in dataManager.savedEntities {
            total += transaction.amount
        }
        
        return total
    }
    
    
    var topCat: String {
        var arry: [String] = []
        
        for transaction in dataManager.savedEntities {
            arry.append(transaction.category ?? "")

        }
        
        return arry.filtered().first ?? "No Category Recorded"
    }
    
    var topPayment: String {
        var arry: [String] = []
        
        for transaction in dataManager.savedEntities {
            arry.append(transaction.bank ?? "")
        }
        
        return arry.filtered().first ?? "No Payment Recorded"
    }
}
