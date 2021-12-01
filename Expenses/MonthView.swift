//
//  MonthView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/30/21.
//

import SwiftUI

struct MonthView: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Total spent")
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                    Text("$1,234.56")
                        .font(.system(size: 24, weight: .medium, design: .rounded))
                        .foregroundColor(Color.white)
                        .lineLimit(2)
                }
                Spacer()
            }
            .padding(.top)
            .padding(.leading)
            .padding(.trailing)
            Spacer()
            HStack {
                Image(systemName: "chevron.down.circle.fill")
                Text("17%")
                Spacer()
            }
            .padding(.horizontal)
            .foregroundColor(Color(.displayP3, red: 148.65/255, green: 251.8/255, blue: 109.72/255))
            Spacer()
            HStack {
                VStack {
                    Text("This month")
                }
                Spacer()
            }
            .padding()
        }
        .foregroundColor(Color.white)
        .background(LinearGradient(gradient: Gradient(colors: [Color(.displayP3, red: 127.01/255, green: 165.62/255, blue: 248.33/255), Color.blue]), startPoint: .top, endPoint: .bottom), alignment: .center)    }
}

