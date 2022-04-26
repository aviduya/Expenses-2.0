//
//  CoreDataHandler.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/7/22.
//

import CoreData
import Foundation

class CoreDataHandler: ObservableObject {
    
    static let shared = CoreDataHandler()
    
    @Published var savedEntities: [TransactionEntity] = []
    @Published var today: [TransactionEntity] = []
    @Published var week: [TransactionEntity] = []
    @Published var month: [TransactionEntity] = []
    
    private var formatFrom: String = "%@ <= %K"
    private var formatTo: String = "%K < %@"
    
    private let container: NSPersistentContainer
    
    private let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    private var calendar = Calendar.current
    
    private init() {
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
        do  {
            savedEntities = try container.viewContext.fetch(request)
            fetchTransactionsToday()
            fetchTransactionsWeek()
            fetchTransactionsMonth()
        } catch let error {
            print("Error Fetching. \(error)")
        }
    }
    
    private func fetchTransactionsToday() {
        
        let dateFrom = calendar.startOfDay(for: Date())
        let dateTo = calendar.date(byAdding: .day, value: 1,  to: dateFrom)
        
        let fromPredicate = NSPredicate(format: formatFrom, dateFrom as NSDate, #keyPath(TransactionEntity.date))
        let toPredicate = NSPredicate(format: formatTo, #keyPath(TransactionEntity.date), dateTo! as NSDate)
        
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        request.predicate = datePredicate
        
        do  {
            today = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching. \(error)")
        }
    }
    
    private func fetchTransactionsWeek() {
        
        let dateFrom = calendar.startOfDay(for: Date().startOfWeek())
        let dateTo = calendar.date(byAdding: .day, value: 7,  to: dateFrom)
        
        let fromPredicate = NSPredicate(format: formatFrom, dateFrom as NSDate, #keyPath(TransactionEntity.date))
        let toPredicate = NSPredicate(format: formatTo, #keyPath(TransactionEntity.date), dateTo! as NSDate)
        
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        request.predicate = datePredicate
        
        do  {
            week = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching. \(error)")
        }
    }
    
    private func fetchTransactionsMonth() {
        
        let dateFrom = Date().getThisMonthStart()
        let dateTo = Date().getThisMonthEnd()
        
        let fromPredicate = NSPredicate(format: formatFrom, dateFrom! as NSDate, #keyPath(TransactionEntity.date))
        let toPredicate = NSPredicate(format: formatTo, #keyPath(TransactionEntity.date), dateTo! as NSDate)
        
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        request.predicate = datePredicate
        
        do  {
            month = try container.viewContext.fetch(request)
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
