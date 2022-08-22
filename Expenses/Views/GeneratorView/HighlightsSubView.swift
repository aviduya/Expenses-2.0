//
//  HighlightsSubView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/22/22.
//

import SwiftUI

struct HighlightsSubView: View {
    
    @State var payment: String?
    @State var category: String?
    @State var merchant: String?
    @State var amount: Double
    @State var paymentAmount: Int

    var body: some View {
            
        VStack(alignment: .leading, spacing: 20) {
            Text("Spending Statistics")
                .opacity(0.33)
            HStack {
                VStack {
                    VStack(alignment: .leading) {
                        Text("Top Payment")
                            .font(.footnote)
                       
                        if let payment = payment {
                            Text(payment)
                                .foregroundColor(.themeThree)
                                .font(.headline)
                        }
                    }
                    .highlightSubViewStyle(maxHeight: 75)
                    
                    
                    VStack(alignment: .leading) {
                        Text("Top Category")
                            .font(.footnote)
                        if let category = category {
                            Text(category)
                                .foregroundColor(.themeThree)
                                .font(.headline)
                        }
                    }
                    .highlightSubViewStyle(maxHeight: 75)
                }
                
                
                VStack(alignment: .leading) {
                    Text("Total Amount")
                        .font(.footnote)
                    Spacer()
                    if let amount = amount {
                        Text("$\(amount, specifier: "%.2f")")
                            .foregroundColor(.themeThree)
                            .font(.system(.title, design: .rounded))
                    }
                    
                    Spacer()
                    
                }
                .highlightSubViewStyle(maxHeight: 161)
                
            }
            
            Divider()
            
            Text("Highlights")
                .opacity(0.33)
            HStack {
                Image(systemName: "building.columns")
                    .foregroundColor(.orange)
                    .font(.title2)
                    .frame(width: 30, height: 30)
                Divider()
                    .frame(height: 30)
                if let payment = payment {
                    Text("You have used your \(payment) account \(paymentAmount) times in this selected period.")
                }
                
            }
            
            HStack {
                Image(systemName: "tag")
                    .foregroundColor(.blue)
                    .font(.title2)
                    .frame(width: 30, height: 30)
                Divider()
                    .frame(height: 30)
                if let merchant = merchant {
                    Text("Your favorite place to shop at was \(merchant).")
                }
                
            }
            
            HStack {
                Image(systemName: "checklist")
                    .foregroundColor(.green)
                    .font(.title2)
                    .frame(width: 30, height: 30)
                Divider()
                    .frame(height: 30)
                if let category = category {
                    Text("You mostly spend your money on \(category) during this set period.")
                }
                
            }
            
            
            
        }
    }
}
