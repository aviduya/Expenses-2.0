//
//  AddTransactionsVM.swift
//  Expenses
//
//  Created by Anfernee Viduya on 3/29/22.
//

import Foundation
import CoreData
import UIKit
import CoreLocation

class AddTransactionsViewModel: ObservableObject {
    
    @Published var areFieldsValid: Bool = true
    @Published var isShowingAlert: Bool = false
    
    let dataManager = CoreDataHandler.shared
    
    init() {
        
    }
    
    func saveTransaction(amount: Double?, name: String, bank: String, merchant: String, category: String, date: Date, coordinate: CLLocationCoordinate2D, _ completionHandler: () -> Void) {
        
        let generator = UINotificationFeedbackGenerator()
        
        if amount == 0.0  || name.isEmpty || merchant.isEmpty {
            
            generator.notificationOccurred(.error)
            areFieldsValid = false
            isShowingAlert = true
            
        } else {
            
            let container: NSPersistentContainer
            container = NSPersistentContainer(name: "TransactionsContainer")
            
            container.loadPersistentStores { (description, error) in
                if let error = error {
                    print("Error: Failed to load CoreData Container \(error)")
                }
                print("CoreData container loaded successfully")
            }
            
            let newTransaction = TransactionEntity(context: container.viewContext)
            
            newTransaction.id = UUID()
            newTransaction.amount = amount ?? 0.0
            newTransaction.name = name
            newTransaction.bank = bank
            newTransaction.merchant = merchant
            newTransaction.category = category
            newTransaction.date = date
            newTransaction.longitude = coordinate.longitude
            newTransaction.latitude = coordinate.latitude
            
            do {
                try container.viewContext.save()
                completionHandler()
                dataManager.getEverything()
                areFieldsValid = true
                isShowingAlert = false
            } catch let error {
                print("Error: Failed to save data: \(error)")
            }
        
        }
        
        
      
    }
}
