//
//  RowView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/22/22.
//

import SwiftUI



struct RowView: View {
   
    
    @State var item: String
    @State var date: Date
    @State var amount: Double
    @State var category: String
    
 
    var todayFormatter: String {
        
        let input = Calendar.current.dateComponents([.day], from: date)
        let dateTo = Calendar.current.dateComponents([.day], from: Date())
        
        let yesterday = Calendar.current.dateComponents([.day], from: Date().getYesterday() ?? Date())
        
        
        if input == dateTo {
            return "Today"
        } else if input == yesterday {
            return "Yesterday"
        }
        
        return date.formatted()
    }
    
    private let material: Material = .regularMaterial
    
    var body: some View {
        HStack {
 
            VStack(alignment: .leading) {
                Text(item)
                    .bold()
                Text(todayFormatter)
                    .font(.caption)
                    .opacity(0.5)
            }
            Spacer()
            Text("$\(amount, specifier: "%.2f")")
        }
        .padding(10)
        .background(material, in: RoundedRectangle(cornerRadius: 10))
        
        
    }
}
