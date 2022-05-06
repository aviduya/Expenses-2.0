//
//  EmptyView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 5/3/22.
//

import SwiftUI

struct EmptyView: View {
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack(alignment: .leading, spacing: 10) {
                    Text("To get started.")
                    Text("Add a Transaction")
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
