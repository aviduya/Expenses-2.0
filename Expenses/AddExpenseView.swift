//
//  AddExpenseView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/24/21.
//

import SwiftUI

struct AddExpenseView: View {
    @Environment(\.managedObjectContext) var dataModel
    @Environment(\.dismiss) var dismiss
    
    @State private var amount = ""
    @State private var name = ""
    @State private var bank: Banks = .schwab
    @State private var merchant = ""
    @State private var type: Types = .inperson
    @State private var category: Categories = .personal
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            VStack {
                
                TextField("$0.00", text: $amount)
                    .padding()
                    .font(Font.largeTitle.weight(.bold))
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                
                Divider()
                    .padding(.horizontal)
                
                TextField("Item Purchased", text: $name)
                    .padding()
                    .font(Font.largeTitle.weight(.bold))
                    .multilineTextAlignment(.center)
                
                Form {
                    Section {
                        DatePicker(selection: $date, in: ...Date(), displayedComponents: .date, label: {Text("Date")})
                    }
                    
                    Section {
                        TextField("Merchant", text: $merchant)
                        Picker("Bank", selection: $bank) {
                            ForEach(Banks.allCases, id: \.self) { bank in
                                Text(bank.rawValue.capitalized).tag(bank)
                            }
                        }
                        .pickerStyle(.menu)
                        Picker("Category", selection: $category) {
                            ForEach(Categories.allCases, id: \.self) { category in
                                Text(category.rawValue.capitalized).tag(category)
                            }
                        }
                        .pickerStyle(.menu)
                        Picker("Type", selection: $type) {
                            ForEach(Types.allCases, id: \.self) { type in
                                Text(type.rawValue.capitalized)
                                    .tag(type)
                            }
                        }
                        .pickerStyle(.segmented)
                        
                    } header: {
                        Text("Additional Details")
                    }
                    
                    Section {
                        Button(action: {
                            saveExpense()
                        }, label: {
                            HStack {
                                Image(systemName: "square.and.arrow.down.on.square")
                                Text("Add Expense")
                            }
                            
                        })
                    }
                    
                    
                }
            }
            
            .navigationTitle("Add Expense ")
        }
    }
    
    func saveExpense() {
        let newExpense = Expense(context: dataModel)
        newExpense.id = UUID()
        newExpense.amount = Double(self.amount) ?? 0.0
        newExpense.date = date
        newExpense.name = name
        newExpense.merchant = merchant
        newExpense.bank = bank.rawValue
        newExpense.type = type.rawValue
        newExpense.category = category.rawValue
        
        try? dataModel.save()
        dismiss()
    }
}


