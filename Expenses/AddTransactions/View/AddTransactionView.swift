//
//  AddTransactionView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/29/22.
//

import SwiftUI
import CustomInputFieldsFramework

struct AddTransactionView: View {
    
    @StateObject var vm = AddTransactionsVM()
    
    @State var model =
    AddTransactionsModel(
        amount: nil,
        name: "",
        bank: .schwab,
        merchant: "",
        category: .personal,
        date: Date())

    var body: some View {
        NavigationView {
            VStack {
                header
                formBox
                Spacer()
            }
            .navigationTitle("Add Expense")
        
        }
    }
}

extension AddTransactionView {
    private var header: some View {
            VStack(alignment: .leading, spacing: 20) {
                Text(model.name)
                    .font(Font.system(.largeTitle, design: .default).weight(.bold))        
                Text("$\(model.amount ?? 0.0,specifier: "%.2f")")
                    .font(Font.system(.largeTitle, design: .rounded).weight(.bold))
                        
                Divider()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .clipped()
            .padding()
        
    }
    
    
    
    private var formBox: some View {
            
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Transaction Details")
                    .font(.subheadline)
                    .opacity(0.30)
                InputValueField(input: $model.amount)
                InputTextField(input: $model.name)
                DatePickerView(date: $model.date)
                GroupBoxPickersView(categories: $model.category, banks: $model.bank)
                Button(action: {
                                    }) {
                    Text("Save Expense")
                }.buttonStyle(CustomButtonStyle())
            }
        }
        .padding()
            
    }
}

fileprivate struct CustomButtonStyle: ButtonStyle {
    public func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(Font.body.weight(.medium))
            .padding(.vertical, 20)
            .foregroundColor(Color.white)
            .frame(maxWidth: .infinity)
            .background(
                RoundedRectangle(cornerRadius: 14.0, style: .continuous)
                    .fill(Color.accentColor)
                )
            .opacity(configuration.isPressed ? 0.4 : 1.0)
    }
}
