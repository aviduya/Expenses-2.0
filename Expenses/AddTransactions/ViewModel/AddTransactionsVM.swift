//
//  AddTransactionsVM.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/29/22.
//

import Foundation
import CoreData

class AddTransactionsVM: ObservableObject {
    
    @Published var savedEntities: [TransactionEntity] = []
    
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "TransactionsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("error loading core data. \(error)")
            } else {
                print("Loaded Core Data")
            }
        }
        fetchTransactions()
    }
    
    func fetchTransactions() {
        let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        
        do  {
           savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching. \(error)")
        }
    }
    
    func addTransactions(
        amount: Double,
        name: String,
        bank: Banks,
        merchant: String,
        type: Types,
        category: Categories,
        date: Date) {

            let newTransaction = TransactionEntity(context: container.viewContext)

            newTransaction.amount = amount
            newTransaction.name = name
            newTransaction.bank = bank.rawValue
            newTransaction.merchant = merchant
            newTransaction.type = type.rawValue
            newTransaction.category = category.rawValue
            newTransaction.date = date

            saveData()
        }
    
    func saveData() {
        do {
            try container.viewContext.save()
            fetchTransactions()
        } catch let error {
            print("Error Saving. \(error)")
        }
        
       
    }
    
    
    
}
