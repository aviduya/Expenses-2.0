//
//  CustomButtonStyle.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/22/22.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    
    private let material: Material = .ultraThin
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.body.weight(.medium))
            .padding(.vertical, 20)
            .foregroundColor(.themeThree)
            .frame(maxWidth: .infinity)
            .background(material, in:
                RoundedRectangle(cornerRadius: 14.0, style: .continuous)
            )
            .opacity(configuration.isPressed ? 0.4 : 1.0)
    }
}
