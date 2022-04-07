//
//  InputFieldView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/1/22.
//

import SwiftUI

struct InputFieldValueView: View {
    
    @Binding var input: Double?
    
    private let selectedMaterial: Material = .thin
    
    var body: some View {
            HStack {
                Text("Amount")
                    .bold()
                    .foregroundStyle(.primary)
                    .padding()
                VStack {
                    TextField("", value: $input, format: .currency(code: "usd"))
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
