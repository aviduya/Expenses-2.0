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
    
}

struct HomeSummaryStyle: ViewModifier {
    
    var isArrayEmpty: Bool
    
    func body(content: Content) -> some View {
        content
            .redacted(reason: isArrayEmpty ? .placeholder : [])
            .shimmering(active: isArrayEmpty)
            .font(.system(size: 35, weight: .regular, design: .rounded))
    }
    
}
