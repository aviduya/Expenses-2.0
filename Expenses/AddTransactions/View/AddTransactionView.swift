//
//  AddTransactionView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/29/22.
//

import SwiftUI

struct AddTransactionView: View {
    
    @StateObject var vm = AddTransactionsVM()
    
    @State var model =
    AddTransactionsModel(
        amount: nil,
        name: "Item",
        bank: .schwab,
        merchant: "",
        type: .inperson,
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
                Text("$\(model.amount ?? 0.0,specifier: "%.2f")")
                    .font(Font.system(.largeTitle, design: .rounded).weight(.bold))
                Text(model.name)
                    .font(Font.system(.largeTitle, design: .default).weight(.bold))
                    .opacity(model.name == "Item" ? 0.30 : 1)
                
                Divider()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .clipped()
            .padding()
        
    }
    
    
    
    private var formBox: some View {
        
        ScrollView {
            VStack {
                InputFieldValueView(input: $model.amount)
            }
        }
           
                
               
                
//                TextField("Amount", value: $model.amount, format: .currency(code: "usd"))
//                TextField("Item", text: $model.name)
//                    .onTapGesture {
//                        model.name = ""
//                    }
//                TextField("Merchant", text: $model.merchant)
//                Picker("bank", selection: $model.bank) {
//                    ForEach(Banks.allCases, id: \.self) { bank in
//                        Text(bank.rawValue.capitalized).tag(bank)                    }
//                }
//                .pickerStyle(.menu)
//                Picker("Category", selection: $model.category) {
//                    ForEach(Categories.allCases, id: \.self) { category in
//                        Text(category.rawValue.capitalized).tag(category)                    }
//                }
//                .pickerStyle(.menu)
//
//                DatePicker(selection: $model.date,
//                    in: ...Date(),
//                    displayedComponents: .date,
//                    label: {
//                        Text("Date of Purchase")
//                    }
//                )
//
//
//
//                Picker("Type", selection: $model.type) {
//                    ForEach(Types.allCases, id: \.self) { type in
//                        Text(type.rawValue.capitalized)
//                            .tag(type)
//                    }
//                }
//                .pickerStyle(.segmented)
            
    }
   

    
}

// TODO: Create individual components for inputs in addTransactionViews
// TODO: Create new Handler of Core Data that can manage containers throughout lifecycle
// TODO: Refine Recent Row Views and move over to MVVM.
// TODO: Look into core data relationship and additional entitities
// TODO: GitHub problem indicator for project and task management.
