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
    
    @StateObject var dm = CoreDataHandler.shared
    @StateObject var vm = AddTransactionsViewModel()
    
    @State var model =
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
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    
                    header
                    
                    formBox
                    
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
                        Text("Save")
                    }
                    .padding()
                    .buttonStyle(CustomButtonStyle())
                    .disabled(settings.banks.isEmpty && settings.categories.isEmpty)
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
            
            
        }
        .alert("Complete Details", isPresented: $vm.isShowingAlert) {
            Button("OK", role: .cancel) { }
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
                
                InputValueField(input: $model.amount, isValidated: $vm.areFieldsValid)
                
                InputTextField(input: $model.name, isValidated: $vm.areFieldsValid, placeholder: "Item...")
                
                InputTextField(input: $model.merchant, isValidated: $vm.areFieldsValid, placeholder: "Merchant...")
                
                DatePickerView(date: $model.date)
                
                GroupBoxPickersView(categoryInput: $model.category, bankInput: $model.bank)
            }
            .padding()
            
        }
    }
}

