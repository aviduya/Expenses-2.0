//
//  RowView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/22/22.
//

import SwiftUI



struct RowView: View {
    
    @Environment(\.editMode) var editMode
    @EnvironmentObject var settings: AppSettingsViewModel
    @AppStorage(Keys.threshold.rawValue) var setThreshold: Double = 0.0
    
    let entity: TransactionEntity
    @Binding var entities: [TransactionEntity]
    let onDelete: (IndexSet) -> ()
    
    @State var item: String
    @State var date: Date
    @State var amount: Double
    @State var category: String
    
    var gradientBackground: LinearGradient {
        
        func returnGradient(_ color1: Color, _ color2: Color) -> LinearGradient {
            return LinearGradient(colors: [color1, color2], startPoint: .topLeading, endPoint: .bottomLeading)
        }
        
        let green = returnGradient(.primaryGreen, .primaryOrange)
        let orange = returnGradient(.primaryOrange, .secondaryOrange)
        let red = returnGradient(.primaryRed, .secondaryRed)
        
        var thresholdStart: Double {
            let t = setThreshold
            return  t / 3
        }
        
        var thresholdEnd: Double {
            let t = setThreshold
            return t / (2/3)
        }
        
        switch amount {
        case 0..<thresholdStart:
            return green
        case thresholdStart...thresholdEnd:
            return orange
        case setThreshold...:
            return red
        default:
            return returnGradient(.black, .black)
        }
        
    }
    
    var todayFormatter: String {
        
        let input = Calendar.current.dateComponents([.day], from: date)
        let dateTo = Calendar.current.dateComponents([.day], from: Date())
        
        let yesterday = Calendar.current.dateComponents([.day], from: Date().getYesterday() ?? Date())
        
        
        if input == dateTo {
            return "Today"
        } else if input == yesterday {
            return "Yesterday"
        }
        
        return date.formatted()
    }
    
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
                        .font(.body)
                        .foregroundColor(Color.red)
                        .frame(width: 40, height: 40)
                }
            } else {
                Text(category.prefix(1).capitalized)
                    .frame(width: 40, height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .fill(gradientBackground)
                    
                    )
            }
            Divider()
            VStack(alignment: .leading) {
                Text(item)
                    .bold()
                Text(todayFormatter)
                    .font(.caption)
                    .opacity(0.5)
            }
            Spacer()
            Text("$\(amount, specifier: "%.2f")")
        }
        .padding(10)
        .background(material, in: RoundedRectangle(cornerRadius: 10))
        
        
    }
}
