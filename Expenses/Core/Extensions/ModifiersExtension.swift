//
//  ModifiersExtension.swift
//  Expenses
//
//  Created by Anfernee Viduya on 7/23/22.
//

import Foundation
import SwiftUI

extension View {
    
    func homeSummaryStyle(for isArrayEmpty: Bool) -> some View {
        modifier(HomeSummaryStyle(isArrayEmpty: isArrayEmpty))
    }
    
    func addTransactionTitleStyle() -> some View {
        modifier(AddTransactionTitleStyle())
    }
    
    func appSettingsListStyle(color: Color) -> some View {
        modifier(AppSettingsListStyle(color: color))
    }
    
    func appSettingsThresholdStyle(primary: Color, secondary: Color) -> some View {
        modifier(AppSettingsThresholdStyle(primaryColor: primary, secondaryColor: secondary))
    }
    
}

fileprivate struct HomeSummaryStyle: ViewModifier {
    
    var isArrayEmpty: Bool
    
    func body(content: Content) -> some View {
        content
            .redacted(reason: isArrayEmpty ? .placeholder : [])
            .shimmering(active: isArrayEmpty)
            .font(.system(size: 35, weight: .regular, design: .rounded))
    }
    
}

fileprivate struct AddTransactionTitleStyle: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .font(Font.system(.largeTitle, design: .default).weight(.bold))
            .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
    }
    
}

fileprivate struct AppSettingsListStyle: ViewModifier {
    
    var color:  Color
    
    func body(content: Content) -> some View {
        content
            .frame(width: 20, height: 20)
            .foregroundColor(color)
    }
    
}
fileprivate struct AppSettingsThresholdStyle: ViewModifier {
    var primaryColor: Color
    var secondaryColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 24, weight: .bold, design: .rounded))
            .frame(width: 150, height: 100, alignment: .center)
            .background(RoundedRectangle(cornerRadius: 5)
                .fill(LinearGradient(colors: [primaryColor, secondaryColor], startPoint: .topLeading, endPoint: .bottomTrailing))
            )
        
    }
    
}
