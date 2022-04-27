//
//  AddTransactionView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/29/22.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var dataManager = CoreDataHandler.shared
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
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
            }
            
        }
        
        .alert("Complete Details", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        }
        .onDisappear {
            dataManager.getEverything()
        }
    }
}

extension AddTransactionView {
    private var header: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(model.name)
                .font(Font.system(.largeTitle, design: .default).weight(.bold))
                .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
            Text("$\(model.amount ?? 0.0, specifier: "%.2f")")
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
                InputTextField(input: $model.name, isValidated: $fieldsValid, placeholder: "Item...")
                InputTextField(input: $model.merchant, isValidated: $fieldsValid, placeholder: "Merchant...")
                DatePickerView(date: $model.date)
                GroupBoxPickersView(categories: $model.category, banks: $model.bank)
                Spacer()
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

