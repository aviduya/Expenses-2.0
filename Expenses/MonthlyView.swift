//
//  MonthlyView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/30/21.
//

import SwiftUI

struct MonthlyView: View {
    @State private var months: Months = .jan
    var body: some View {
        
                Section {
                    ForEach(Months.allCases, id: \.self) { month in
                        
                        Text(month.rawValue)
                        
                }
              
                } header: {
                    HStack {
                        Image(systemName: "calendar.day.timeline.right")
                        Text("2021")
                    }
                   
                }
    }
}
