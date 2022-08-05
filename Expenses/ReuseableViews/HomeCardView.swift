//
//  HomeCardView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 7/22/22.
//

import Foundation
import SwiftUI




VStack(alignment: .leading) {
    VStack(alignment: .leading) {
        Text("The Item")
            .font(.title)
        Text("Yesterday")
            .font(Font.system(.callout, design: .default))
            .opacity(0.5)
        Spacer()
        HStack {
            Text("$300")
                .font(.system(size: 50, weight: .regular, design: .default))
            Spacer()
            VStack(alignment: .trailing) {
                Text("Shopping")
                Text("Chase")
            }
        }
    }
    .padding(30)
}
.frame(width: 300, height: 200, alignment: .topLeading)
.clipped()
.overlay(RoundedRectangle(cornerRadius: 10, style: .continuous)
    .frame(width: 40, height: 40, alignment: .topTrailing)
    .clipped(), alignment: .topTrailing)
.background(RoundedRectangle(cornerRadius: 14, style: .continuous)
    .fill(Color(.systemFill))
    .padding(), alignment: .center)
