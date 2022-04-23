//
//  RowView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/22/22.
//

import SwiftUI

struct RowView: View {
    
    @State var item: String
    @State var date: String
    @State var amount: Double?
    @State var category: String
    
    var body: some View {
        HStack {
            Image(systemName: convertSymbols(category))
                .frame(width: 30)
            Divider()
            VStack(alignment: .leading) {
                Text(item)
                    .bold()
                Text(date)
                    .font(.caption)
                    .opacity(0.5)
            }
            Spacer()
            Text("$\(amount ?? 0.0, specifier: "%.2f")")
        }
    }
    
    func convertSymbols(_ category: String) -> String {
        
        switch category.lowercased() {
        case "groceries":
            return "cart"
        case "bills":
            return "list.bullet.rectangle.portrait"
        case "personal":
            return "person.fill"
        case "necesities":
            return "person.text.rectangle.fill"
        case "other":
            return "questionmark"
        default:
            return "xmark.diamond"
        }
    
    }
    
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(item: "", date: "", category: "")
    }
}
