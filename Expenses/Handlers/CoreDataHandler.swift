//
//  CoreDataHandler.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/7/22.
//

import CoreData
import Foundation

class CoreDataHandler: ObservableObject {
    static let dataManager = CoreDataHandler()
    
    @Published var transactions: [AddTransactionsModel] = []
    var entity: [TransactionEntity] = []
    
    
    
}
