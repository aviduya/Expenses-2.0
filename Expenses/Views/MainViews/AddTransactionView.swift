//
//  AddTransactionView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/29/22.
//

import SwiftUI

struct AddTransactionView: View {
    
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var settings: AppSettingsViewModel
    @StateObject var vm = AddTransactionsViewModel()
    
    
    @State private var counter: Int = 0
    @State private var model =
    AddTransactionsModel(
        amount:
            nil,
        name:
            "",
        bank:
            "",
        merchant:
            "",
        category:
            "",
        date:
            Date())
    
    // MARK: Main View
    
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 20) {
                    
                    header
                    
                    formBox
                    
                    Spacer()
                    addTransactionButton
                    
                }
                
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                            .foregroundColor(.red)
                    }
                }
            }
        }
        .alert("Complete Details", isPresented: $vm.isShowingAlert) {
            Button("OK", role: .cancel) { }
        }
        .overlay(settings.areOptionsEmpty ? emptyTransactionsView : nil)
    }
}

// MARK: Extension of AddTransactionsView


extension AddTransactionView {
    
    // MARK: Empty transactions view
    
    private var emptyTransactionsView: some View {
        VStack {
            Text("Add an Bank & Catergory in settings to get started.")
                .font(.title)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 10))
        .ignoresSafeArea()
        
    }
    
    // MARK: Save Transactions
    
    private var addTransactionButton: some View {
        
        Button(action: {
            vm.saveTransaction(
                amount:
                    model.amount,
                name:
                    model.name,
                bank:
                    model.bank,
                merchant:
                    model.merchant,
                category:
                    model.category,
                date:
                    model.date) {
                        dismiss()
                    }
        }) {
            Text("Save Transaction")
        }
        .padding()
        .buttonStyle(CustomButtonStyle())
        .shadow(radius: 10)
        .background(in: RoundedRectangle(cornerRadius: 10))
        
        
    }
    
    // MARK: Header and title
    
    private var header: some View {
        VStack(alignment: .leading) {
            
            if model.name.isEmpty {
                Text("Item...")
                    .foregroundColor(.themeThree)
                    .addTransactionTitleStyle()
                    .opacity(0.33)
            } else {
                
                Text(model.name)
                    .foregroundColor(.themeThree)
                    .addTransactionTitleStyle()
            }
            
            Text("$\(model.amount ?? 0.0, specifier: "%.2f")")
                .foregroundColor(.themeThree)
                .font(Font.system(.largeTitle, design: .rounded).weight(.bold))
            
            Divider()
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
    
    // MARK: Main transactions form
    
    
    private var formBox: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Transaction Details")
                .font(.subheadline)
                .opacity(0.30)
            
            InputValueField(input: $model.amount, isValidated: $vm.areFieldsValid)
                .foregroundColor(.themeThree)
            
            
            InputTextField(input: $model.name, isValidated: $vm.areFieldsValid, placeholder: "Item...")
                .foregroundColor(.themeThree)
            
            InputTextField(input: $model.merchant, isValidated: $vm.areFieldsValid, placeholder: "Merchant...")
                .foregroundColor(.themeThree)
            
            DatePickerView(date: $model.date)
                .foregroundColor(.themeThree)
            
            GroupBoxPickersView(categoryInput: $model.category, bankInput: $model.bank)
                .foregroundColor(.themeThree)
            
        }
        .padding()
        
    }
    
}

