//
//  InputFieldTextView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/3/22.
//

import SwiftUI

struct InputFieldTextView: View {
    
    @Binding var input: String
    
    private let selectedMaterial: Material = .thin
    
    var body: some View {
        HStack {
            Text("Name")
                .bold()
                .foregroundStyle(.primary)
                .padding()
            VStack {
                TextField("", text: $input)
                    .font(Font.headline.weight(.bold))
                    .multilineTextAlignment(.trailing)
            }
            .padding()
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .clipped()
        .background(selectedMaterial, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
        
        
    }
}


