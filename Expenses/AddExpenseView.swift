//
//  AddExpenseView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/24/21.
//

import SwiftUI

extension String {
    func toDouble() -> Double? {
        return NumberFormatter().number(from: self)?.doubleValue
    }
}

struct AddExpenseView: View {
    @Environment(\.managedObjectContext) var dataModel
    @Environment(\.dismiss) var dismiss
    
    //TODO: Create a field for asking what type of expense would it be. 
    
    @State private var amount = ""
    @State private var name = ""
    @State private var bank = "Charles Schwab"
    @State private var merchant = ""
    @State private var type = "In-Person"
    @State private var category = ""
    @State private var date = Date()
        
    let banks: [String] = ["Chase", "Capital One", "Apple Card", "Charles Schwab", "American Express"]
    
    let types = ["Online", "In-Person"]
    
    let categories = ["Groceries", "Bills", "Personal", "Other", "Necesities"]
     
    
 
    
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
                
                Form {
                    Section {
                        DatePicker(selection: $date, in: ...Date(), displayedComponents: .date, label: {Text("Date")})
                        TextField("Item Purchased", text: $name)
        
                    }
                    
                    Section {
                        TextField("Merchant", text: $merchant)
                        Picker("Bank", selection: $bank) {
                            ForEach(banks, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        Picker("Category", selection: $category) {
                            ForEach(categories, id: \.self) {
                                Text($0)
                            }
                        }
                        .pickerStyle(.menu)
                        Picker("Type", selection: $type) {
                            ForEach(types, id: \.self) {
                                Text($0)
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
        // Converts the amount String -> Double? Unwrapped since CoreData init(<Double?>)
        newExpense.amount = Double(self.amount) ?? 0.0
        newExpense.date = date
        newExpense.name = name
        newExpense.merchant = merchant
        newExpense.bank = bank
        newExpense.type = type
        newExpense.category = category
        
        try? dataModel.save()
        dismiss()
    }
}


