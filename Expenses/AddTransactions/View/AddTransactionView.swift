//
//  AddTransactionView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/29/22.
//

import SwiftUI

struct AddTransactionView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: AppSettings
    @StateObject var dataManager = CoreDataHandler.shared
    @ObservedObject var vm = AddTransactionsVM()
    @State private var fieldsValid = true
    @State private var showingAlert = false
    
    @State var model =
    AddTransactionsModel(
        amount: nil,
        name: "",
        bank: "Chase",
        merchant: "",
        category: "Personal",
        date: Date())
    
    var body: some View {
        NavigationView {
            VStack {
                header
                formBox
                Button(action: {
                    vm.save(amount: model.amount ?? 0.0, name: model.name, merchant: model.merchant) {
                        fieldsValid = false
                        showingAlert = true
                    } _: {
                        fieldsValid = true
                        dataManager.addTransactions(
                            amount: model.amount,
                            name: model.name,
                            bank: model.bank,
                            merchant: model.merchant,
                            category: model.category,
                            date: model.date)
                        dismiss()
                    }

                }) {
                    Text("Save")
                }
                .padding()
                .buttonStyle(CustomButtonStyle())
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
        VStack(alignment: .leading) {
            
            if model.name.isEmpty {
                Text("Name...")
                    .font(Font.system(.largeTitle, design: .default).weight(.bold))
                    .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
                    .opacity(0.33)
            } else {
                Text(model.name)
                    .font(Font.system(.largeTitle, design: .default).weight(.bold))
                    .frame(maxWidth: .infinity, minHeight: 50, alignment: .leading)
            }
            
            
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
                GroupBoxPickersView(categoryInput: $model.category, bankInput: $model.bank)
            }
            .padding()
            
        }
    }
}

