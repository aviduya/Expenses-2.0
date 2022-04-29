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
    
    @Published var yesterday: [TransactionEntity] = []
    @Published var today: [TransactionEntity] = []
    @Published var week: [TransactionEntity] = []
    @Published var month: [TransactionEntity] = []
    @Published var all: [TransactionEntity] = []
    
    private let formatFrom: String = "%@ <= %K"
    private let formatTo: String = "%K < %@"
   

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
        getEverything()
    }
    
    func getEverything() {

        let yesterdayDateTo = calendar.startOfDay(for: Date())
        let yesterdayDateFrom = calendar.date(byAdding: .day, value: -1, to: yesterdayDateTo)
        
        let todayDateFrom = calendar.startOfDay(for: Date())
        let todayDateTo = calendar.date(byAdding: .day, value: 1, to: todayDateFrom)
        
        let weekDateFrom = calendar.startOfDay(for: Date().startOfWeek())
        let weekDateTo = calendar.date(byAdding: .day, value: 7,  to: weekDateFrom)
        
        let monthDateFrom = Date().getThisMonthStart()
        let monthDateTo = Date().getThisMonthEnd()
        
        let yesterdayFromPredicate = NSPredicate(format: formatFrom, yesterdayDateFrom! as NSDate, #keyPath(TransactionEntity.date))
        let yesterdayPredicate = NSPredicate(format: formatTo, #keyPath(TransactionEntity.date), yesterdayDateTo as NSDate)
        
        let todayFromPredicate = NSPredicate(format: formatFrom, todayDateFrom as NSDate, #keyPath(TransactionEntity.date))
        let todayPredicate = NSPredicate(format: formatTo, #keyPath(TransactionEntity.date), todayDateTo! as NSDate)
        
        let weekFromPredicate = NSPredicate(format: formatFrom, weekDateFrom as NSDate, #keyPath(TransactionEntity.date))
        let weekPredicate = NSPredicate(format: formatTo, #keyPath(TransactionEntity.date), weekDateTo! as NSDate)
        
        let monthFromPredicate = NSPredicate(format: formatFrom, monthDateFrom! as NSDate, #keyPath(TransactionEntity.date))
        let monthPredicate = NSPredicate(format: formatTo, #keyPath(TransactionEntity.date), monthDateTo! as NSDate)
        
        let yesterdayRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        let todayRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        let weekRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        let monthRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        
     
        
        let yesterdayDatePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [yesterdayFromPredicate, yesterdayPredicate])
        yesterdayRequest.predicate = yesterdayDatePredicate
        
        let todayDatePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [todayFromPredicate, todayPredicate])
        todayRequest.predicate = todayDatePredicate
        
        let weekDatePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [weekFromPredicate, weekPredicate])
        weekRequest.predicate = weekDatePredicate
        
        let monthDatePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [monthFromPredicate, monthPredicate])
        monthRequest.predicate = monthDatePredicate
        
        
        yesterdayRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        todayRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        weekRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        monthRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        
        do  {
            all = try container.viewContext.fetch(request)
            yesterday = try container.viewContext.fetch(yesterdayRequest)
            today = try container.viewContext.fetch(todayRequest)
            week = try container.viewContext.fetch(weekRequest)
            month = try container.viewContext.fetch(monthRequest)
        } catch let error {
            print("Error Fetching. \(error)")
        }
        
        
    }
    
    func addTransactions(
        amount: Double?,
        name: String,
        bank: String,
        merchant: String,
        category: String,
        date: Date) {
            
            let newTransaction = TransactionEntity(context: container.viewContext)
            
            newTransaction.id = UUID()
            
            newTransaction.amount = amount ?? 0.0
            newTransaction.name = name
            newTransaction.bank = bank
            newTransaction.merchant = merchant
            newTransaction.category = category
            newTransaction.date = date
            
            saveData()
        }
    
    func deleteTransactions(_ indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = all[index]
        
        container.viewContext.delete(entity)
        saveData()
    }
    
    func saveData() {
        do {
            getEverything()
            try container.viewContext.save()
        } catch let error {
            print("Error Saving. \(error)")
        }
        
    }
}
