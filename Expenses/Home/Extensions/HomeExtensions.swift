//
//  HomeExtensions.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/14/22.
//

import Foundation
import SwiftUI

extension HomeView {
     var transactionsList: some View {
        List(dataManager.savedEntities) { entity in
            Text("\(entity.amount)")
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
                Text(topCategory.first ?? "Error")
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
            VStack(alignment: .leading) {
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text(topPayment.first ?? "Error")
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .clipped()
        .padding(.leading, 30.0)
    }
}
