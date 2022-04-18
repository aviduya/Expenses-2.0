//
//  AddTransactionView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/29/22.
//

import SwiftUI
import Expenses_UI_Library

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var dataManager = CoreDataHandler()
    @State var fieldsValid = true
    @State var showingAlert = false
    
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
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        .alert("Complete Details", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .onDisappear {
            dataManager.fetchTransactions()
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
        .padding(.horizontal)
        
    }
    
    
    private var formBox: some View {
        
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 10) {
                Text("Transaction Details")
                    .font(.subheadline)
                    .opacity(0.30)
                InputValueField(input: $model.amount, isValidated: $fieldsValid)
                InputTextField(input: $model.name, placeholder: "Item...", isValidated: $fieldsValid)
                InputTextField(input: $model.merchant, placeholder: "Merchant...", isValidated: $fieldsValid)
                DatePickerView(date: $model.date)
                GroupBoxPickersView(categories: $model.category, banks: $model.bank)
                Button(action: {
                    save()
                }) {
                    Text("Save")
                }.buttonStyle(CustomButtonStyle())
            }
            .padding()
        }
        
    }
    
    func save() {
        let generator = UINotificationFeedbackGenerator()
        let a = model.amount
        let n = model.name
        let m = model.merchant
        
        if a == 0.0 || n.isEmpty || m.isEmpty {
            fieldsValid = false
            showingAlert = true
            generator.notificationOccurred(.error)
            
        } else {
            fieldsValid = true
            dataManager.addTransactions(
                amount: model.amount,
                name: model.name,
                bank: model.bank,
                merchant: model.merchant,
                category: model.category,
                date: model.date)
            generator.notificationOccurred(.success)
            dismiss()
        }
        
    }
}

fileprivate struct CustomButtonStyle: ButtonStyle {
    fileprivate func makeBody(configuration: Self.Configuration) -> some View {
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
