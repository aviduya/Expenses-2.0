//
//  YearView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 5/9/22.
//

import SwiftUI

//TODO: Add navgiationlink() -> under forEach() to direct to another view.

enum Months: String, CaseIterable {
    case jan = "January"
    case feb = "February"
    case mar = "March"
    case apr = "April"
    case may = "May"
    case jun = "June"
    case jul = "July"
    case aug = "August"
    case sep = "September"
    case oct = "October"
    case nov = "November"
    case dec = "Decemober"
}

struct YearView: View {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(Months.allCases, id: \.self) { item in
                            GroupBox {
                                Text("Some Value")
                                    .padding()
                            } label: {
                                Text(item.rawValue)
                            }

                        }
                    }
                }
    }
                       
}

struct YearView_Previews: PreviewProvider {
    static var previews: some View {
        YearView()
    }
}
