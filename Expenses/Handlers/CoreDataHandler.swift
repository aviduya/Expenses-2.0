//
//  CoreDataHandler.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/7/22.
//

import CoreData
import Foundation

class CoreDataHandler: ObservableObject {
    @Published var savedEntities: [TransactionEntity] = []
    @Published var today: [TransactionEntity] = []
    
    let container: NSPersistentContainer
    let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    var calendar = Calendar.current
    
    init() {
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        calendar.timeZone = NSTimeZone.local
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
            fetchTransactionsToday()
        } catch let error {
            print("Error Fetching. \(error)")
        }
    }
    
    func fetchTransactionsToday() {
        
        let dateFrom = calendar.startOfDay(for: Date())
        let dateTo = calendar.date(byAdding: .day, value: 1,  to: dateFrom)
        
        let fromPredicate = NSPredicate(format: "%@ <= %K", dateFrom as NSDate, #keyPath(TransactionEntity.date))
        let toPredicate = NSPredicate(format: "%K < %@", #keyPath(TransactionEntity.date), dateTo! as NSDate)
        
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        request.predicate = datePredicate
        
        do  {
            today = try container.viewContext.fetch(request)
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
