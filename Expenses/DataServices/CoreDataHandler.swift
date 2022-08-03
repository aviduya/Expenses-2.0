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
    
    private let container: NSPersistentContainer
    private var calendar = Calendar.current
    
    private init() {
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
    
    deinit {
        print("Deinitializing handler.")
        
    }
        
    func getTransaction(_ input: inout [TransactionEntity]) {
        
        var sort: [NSSortDescriptor] {
            return [NSSortDescriptor(key: "date", ascending: false)]
        }
        
        let genericRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        genericRequest.sortDescriptors = sort
        
        do {
            input = try container.viewContext.fetch(genericRequest)
            print("Core Data Initialized")
        } catch let error {
            print("Error Fetching. \(error)")
        }
    }
    
    func getRangeOfTransactions(start: Date ,end: Date, _ input: inout [TransactionEntity]) {
        
        func fromPredicate(dateFrom: Date) -> NSPredicate {
            return NSPredicate(format: "%@ <= %K", dateFrom as NSDate, #keyPath(TransactionEntity.date))
        }
        
        func toPredicate(dateTo: Date?) -> NSPredicate {
            return NSPredicate(format: "%K < %@", #keyPath(TransactionEntity.date), dateTo! as NSDate)
        }
        
        func compound(from: NSPredicate, to: NSPredicate) -> NSCompoundPredicate {
            return NSCompoundPredicate(andPredicateWithSubpredicates: [from, to])
        }
        
        func sort() -> [NSSortDescriptor] {
            return [NSSortDescriptor(key: "date", ascending: false)]
        }
        
        let startDate = calendar.startOfDay(for: start)
        let endDate = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: end)
        
        let startDatePredicate = fromPredicate(dateFrom: startDate)
        let endDatePredicate = toPredicate(dateTo: endDate)
        
        let rangeTransactionRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        
        
        let rangePredicate = compound(from: startDatePredicate, to: endDatePredicate)
        rangeTransactionRequest.predicate = rangePredicate
        
        rangeTransactionRequest.sortDescriptors = sort()
        
        do {
            input = try container.viewContext.fetch(rangeTransactionRequest)
        } catch let error {
            print("Error Fetching. \(error)")
        }
        
    }
    
    func getEverything() {
        
        func fromPredicate(dateFrom: Date) -> NSPredicate {
            return NSPredicate(format: "%@ <= %K", dateFrom as NSDate, #keyPath(TransactionEntity.date))
        }
        
        func toPredicate(dateTo: Date?) -> NSPredicate {
            return NSPredicate(format: "%K < %@", #keyPath(TransactionEntity.date), dateTo! as NSDate)
        }
        
        func compound(from: NSPredicate, to: NSPredicate) -> NSCompoundPredicate {
            return NSCompoundPredicate(andPredicateWithSubpredicates: [from, to])
        }
        
        func sort() -> [NSSortDescriptor] {
            return [NSSortDescriptor(key: "date", ascending: false)]
        }
        
        let yesterdayDateTo = calendar.startOfDay(for: Date())
        let yesterdayDateFrom = calendar.date(byAdding: .day, value: -1, to: yesterdayDateTo)
        
        let todayDateFrom = calendar.startOfDay(for: Date())
        let todayDateTo = calendar.date(byAdding: .day, value: 1, to: todayDateFrom)
        
        let weekDateFrom = calendar.startOfDay(for: Date().startOfWeek())
        let weekDateTo = calendar.date(byAdding: .day, value: 7,  to: weekDateFrom)
        
        let monthDateFrom = calendar.startOfDay(for: Date().getThisMonthStart()!)
        let monthDateTo = Date().getThisMonthEnd()
        
        let yesterdayFromPredicate = fromPredicate(dateFrom: yesterdayDateFrom!)
        let yesterdayPredicate = toPredicate(dateTo: yesterdayDateTo)
        
        let todayFromPredicate = fromPredicate(dateFrom: todayDateFrom)
        let todayPredicate = toPredicate(dateTo: todayDateTo!)
        
        let weekFromPredicate = fromPredicate(dateFrom: weekDateFrom)
        let weekPredicate = toPredicate(dateTo: weekDateTo!)
        
        let monthFromPredicate = fromPredicate(dateFrom: monthDateFrom)
        let monthPredicate = toPredicate(dateTo: monthDateTo!)
        
        let allRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        let yesterdayRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        let todayRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        let weekRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        let monthRequest = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
        
        let yesterdayDatePredicate = compound(from: yesterdayFromPredicate, to: yesterdayPredicate)
        yesterdayRequest.predicate = yesterdayDatePredicate
        
        let todayDatePredicate = compound(from: todayFromPredicate, to: todayPredicate)
        todayRequest.predicate = todayDatePredicate
        
        let weekDatePredicate = compound(from: weekFromPredicate, to: weekPredicate)
        weekRequest.predicate = weekDatePredicate
        
        let monthDatePredicate = compound(from: monthFromPredicate, to: monthPredicate)
        monthRequest.predicate = monthDatePredicate
        
        allRequest.sortDescriptors = sort()
        yesterdayRequest.sortDescriptors = sort()
        todayRequest.sortDescriptors = sort()
        weekRequest.sortDescriptors = sort()
        monthRequest.sortDescriptors = sort()
        
        do  {
            all = try container.viewContext.fetch(allRequest)
            yesterday = try container.viewContext.fetch(yesterdayRequest)
            today = try container.viewContext.fetch(todayRequest)
            week = try container.viewContext.fetch(weekRequest)
            month = try container.viewContext.fetch(monthRequest)
            print("Core Data Initialized")
        } catch let error {
            print("Error Fetching. \(error)")
        }
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
