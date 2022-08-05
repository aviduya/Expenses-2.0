//
//  InputTextField.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/22/22.
//

import SwiftUI

struct InputTextField: View {
    
    @Binding var input: String
    @Binding var isValidated: Bool
    
    var placeholder: String
    
    let material: Material = .thin
    
    var icon: String {
        let name = placeholder
        
        switch name {
        case "Item...":
            return "tag"
        case "Merchant...":
            return"building.2"
        default:
            return "Error"
        }
    }
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .frame(maxWidth: 20, maxHeight: 20)
                .padding(.horizontal, 10)
                .font(.title)
            TextField(placeholder, text: $input)
                .font(Font.headline.weight(.bold))
            Spacer()
            if isValidated != true {
                Image(systemName: "exclamationmark")
                    .font(.title2)
                    .foregroundColor(Color.red)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .clipped()
        .background(material, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
}
