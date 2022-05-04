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
                VStack {
                    Image(systemName: "plus.forwardslash.minus")
                        .foregroundColor(Color.green)
                    Text("Add a Transaction")
                }
                .font(.largeTitle)
                
                Spacer()
            }
            Spacer()
        }
        
    }
}
