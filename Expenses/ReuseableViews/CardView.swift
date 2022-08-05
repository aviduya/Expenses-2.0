//
//  CardView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 7/22/22.
//

import SwiftUI

struct CardView: View {
    
    @EnvironmentObject var settings: AppSettingsViewModel
    @AppStorage("threshold") var setThreshold: Double = 0.0
    
    @State var item: String
    @State var date: Date
    @State var amount: Double
    @State var category: String
    
    private var gradientBackground: LinearGradient {
        
        func returnGradient(_ color1: Color, _ color2: Color) -> LinearGradient {
            return LinearGradient(colors: [color1, color2], startPoint: .topLeading, endPoint: .bottomLeading)
        }
        
        let green = returnGradient(.primaryGreen, .primaryOrange)
        let orange = returnGradient(.primaryOrange, .secondaryOrange)
        let red = returnGradient(.primaryRed, .secondaryRed)
        
        var thresholdStart: Double {
            let t = setThreshold
            return  t / 3
        }
        
        var thresholdEnd: Double {
            let t = setThreshold
            return t / (2/3)
        }
        
        switch amount {
        case 0..<thresholdStart:
            return green
        case thresholdStart...thresholdEnd:
            return orange
        case setThreshold...:
            return red
        default:
            return returnGradient(.black, .black)
        }
        
    }
    
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
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                Text(item)
                    .font(.title)
                Text("\(todayFormatter)")
                    .font(Font.system(.callout, design: .default))
                    .opacity(0.5)
                Spacer()
                HStack {
                Text("$\(amount, specifier: "%.2f")")
                    .font(.system(size: 50, weight: .regular, design: .default))
                Spacer()
                }
            }
            .padding(30)
        }
        .clipped()
        .overlay(
            
            Text(category.capitalized)
                .bold()
                .padding(10)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(gradientBackground)
                ),
            alignment: .topTrailing
        )
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color(.systemFill))
                .padding(10)
            , alignment: .center)
        
        .padding(.bottom, 50)
    }
}
