//
//  AllTransactionsVM.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/21/22.
//

import Foundation
import CoreData


class AllTransactionsViewModel: ObservableObject {
    
    @Published var today: [TransactionEntity] = []
    @Published var week: [TransactionEntity] = []
    @Published var month: [TransactionEntity] = []
    
    let container: NSPersistentContainer
    
    let request = NSFetchRequest<TransactionEntity>(entityName: "TransactionEntity")
    var calendar = Calendar.current
    
    init() {
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        calendar.timeZone = NSTimeZone.local
        container = NSPersistentContainer(name: "TransactionsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error loading CoreData. \(error)")
            } else {
                print("Success")
            }
        }
        
        fetchTransactionsToday()
        fetchTransactionsWeek()
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
    
    func fetchTransactionsWeek() {
        
        let dateFrom = calendar.startOfDay(for: Date().startOfWeek())
        let dateTo = calendar.date(byAdding: .day, value: 7,  to: dateFrom)
        
        let fromPredicate = NSPredicate(format: "%@ <= %K", dateFrom as NSDate, #keyPath(TransactionEntity.date))
        let toPredicate = NSPredicate(format: "%K < %@", #keyPath(TransactionEntity.date), dateTo! as NSDate)
        
        let datePredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [fromPredicate, toPredicate])
        request.predicate = datePredicate
        
        do  {
            week = try container.viewContext.fetch(request)
        } catch let error {
            print("Error Fetching. \(error)")
        }
    }
    
    func convertDate(date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MMM d, YY"
        
        return formatter.string(from: date)
    }
}

extension Calendar {
    static let gregorian = Calendar(identifier: .gregorian)
}

extension Date {
    func startOfWeek(using calendar: Calendar = .gregorian) -> Date {
        calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
    }
}
