//
//  EmptyView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 5/3/22.
//

import SwiftUI

struct EmptyView: View {
    
    @State var message: String
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text("To get started,")
                    Text(message)
                        .foregroundColor(.themeThree)
                        .opacity(0.33)
                }
                .padding()
                .font(.title)
                
                Spacer()
            }
            Spacer()
        }
        
    }
}
