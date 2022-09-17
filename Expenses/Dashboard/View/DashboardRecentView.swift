//
//  DashboardRecentView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 9/12/22.
//

import SwiftUI
import CoreLocation
import MapKit

struct DashboardRecentModel: Identifiable {
    var id = UUID().uuidString
    var item: String
    var date: String
    var amount: Double
    var category: String
    var merchant: String
    var bank: String
    var location: CLLocationCoordinate2D
  
    init(id: String = UUID().uuidString, item: String, date: Date, amount: Double, category: String, merchant: String, bank: String, location: CLLocationCoordinate2D) {
        self.id = id
        self.item = item
        self.date = date.formatted()
        self.amount = amount
        self.category = category
        self.merchant = merchant
        self.bank = bank
        self.location = location
    }
    
}


final class DashboardRecentViewModel: ObservableObject {
    
    @Published var transactions: [DashboardRecentModel] = []
    
    let dataManager: CoreDataHandler = .shared
    
    init() {
        reset()
        getTransactions()
        print(transactions)
    }
    
    func reset() {
        transactions = []
    }
    
    func getTransactions() {
        for transaction in dataManager.all {
            transactions.append(
                DashboardRecentModel(
                    item: transaction.name ?? "",
                    date: transaction.date ?? Date.now,
                    amount: transaction.amount,
                    category: transaction.category ?? "",
                    merchant: transaction.merchant ?? "",
                    bank: transaction.bank ?? "",
                    location: CLLocationCoordinate2D(latitude: transaction.latitude, longitude: transaction.longitude)))
        }
    }
}



struct DashboardRecentView: View {
    
    @StateObject var viewModel = DashboardRecentViewModel()
    
    @State private var selectTab: Int = 1

    var body: some View {
        Group {
            TabView(selection: $selectTab) {
                ForEach(viewModel.transactions) { transaction in
                  CardView(
                    item: transaction.item ,
                    date: transaction.date,
                    amount: transaction.amount,
                    category: transaction.category,
                    merchant: transaction.merchant,
                    bank: transaction.bank,
                    location: transaction.location)
                  .padding(.horizontal, 10)
                  
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .onAppear {
            print("This View appeard")
        }
    }
}
