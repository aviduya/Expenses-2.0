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
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]

        do  {
           savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching. \(error)")
        }
    }
    
    func addTransactions(
        amount: Double?,
        name: String,
        bank: Banks,
        merchant: String,
        category: Categories,
        date: Date) {

            let newTransaction = TransactionEntity(context: container.viewContext)
            
            newTransaction.id = UUID()
            newTransaction.amount = amount ?? 0.0
            newTransaction.name = name
            newTransaction.bank = bank.rawValue
            newTransaction.merchant = merchant
            newTransaction.category = category.rawValue
            newTransaction.date = date

          saveData()
        }
    
    func deleteTransactions(_ indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = savedEntities[index]
        
        container.viewContext.delete(entity)
        saveData()
        print(savedEntities.count)
    }
    
    func saveData() {
        do {
            fetchTransactions()
            try container.viewContext.save()
        } catch let error {
            print("Error Saving. \(error)")
        }

    }
    
    
    
}
