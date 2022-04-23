//
//  InputValueField.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/22/22.
//

import SwiftUI

struct InputValueField: View {
    
    @Binding var input: Double?
    @Binding var isValidated: Bool
    
    let material: Material = .thin
    
    var body: some View {
        HStack {
            Image(systemName: "textformat.superscript")
                .font(.title)
            TextField("Amount...", value: $input, format: .currency(code: "usd"))
                .keyboardType(.decimalPad)
                .font(Font.headline.weight(.bold))
                .onTapGesture {
                    isEmpty()
                }
            Spacer()
            if isValidated != true {
                Image(systemName: "exclamationmark")
                    .font(.title2)
                    .foregroundColor(Color.red)
            }
            
        }
        .onAppear {
           isEmpty()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .center)
        .clipped()
        .background(material, in: RoundedRectangle(cornerRadius: 14, style: .continuous))
    }
    
    func isEmpty() {
      if input == 0.0 {
          isValidated = true
      }
  }
}

struct InputValueField_Previews: PreviewProvider {
    static var previews: some View {
        InputValueField(input: .constant(12.0), isValidated: .constant(true))
    }
}
