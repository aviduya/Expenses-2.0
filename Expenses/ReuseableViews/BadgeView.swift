//
//  BadgeView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/22/22.
//

import SwiftUI

struct BadgeView: View {
    let count: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            Text(String(count))
                .font(.system(size: 16))
                .padding(5)
                .background(Color.orange)
                .clipShape(Circle())
                // custom positioning in the top-right corner
                .alignmentGuide(.top) { $0[.bottom] }
                .alignmentGuide(.trailing) { $0[.trailing] - $0.width * 0.40 }
        }
    }
}
