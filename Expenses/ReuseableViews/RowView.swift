//
//  RowView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/22/22.
//

import SwiftUI



struct RowView: View {
    
    @Environment(\.editMode) var editMode
    @EnvironmentObject var settings: AppModel
    
    let entity: TransactionEntity
    @Binding var entities: [TransactionEntity]
    let onDelete: (IndexSet) -> ()
    
    @State var item: String
    @State var date: String
    @State var amount: Double?
    @State var category: String
    
    private let material: Material = .regularMaterial
    
    var body: some View {
        HStack {
            
            if self.editMode?.wrappedValue == .active {
                let generator = UINotificationFeedbackGenerator()
                
                Button(action: {
                    if let index = entities.firstIndex(of: entity) {
                        self.onDelete(IndexSet(integer: index))
                        generator.notificationOccurred(.success)
                    }
                }) {
                    Image(systemName: "minus.circle")
                        .foregroundColor(Color.red)
                        .frame(width: 30)
                }
            } else {
                Image(systemName: convertSymbols(category))
                    .frame(width: 30)
            }
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
        .padding(10)
        .background(material, in: RoundedRectangle(cornerRadius: 10))
        
        
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
