//
//  HomeExtensions.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/14/22.
//

import Foundation
import SwiftUI

//MARK: Extracted Views of HomeView

extension HomeView {
    
    var transactionsList: some View {
        ScrollView {
            Section {
                ForEach(dm.all.prefix(5)) { t in
                    RowView(
                        entity: t,
                        entities: $dm.all,
                        onDelete: dm.deleteTransactions(_:),
                        item: t.name ?? "",
                        date: vm.convertDate(date: t.date ?? Date()),
                        amount: t.amount,
                        category: t.category ?? "")
                }

                
            } header: {
                HStack {
                    Text("5 Most recent transactions")
                        .bold()
                        .opacity(0.63)
                    Spacer()
                }
            } footer: {
                HStack {
                    Text("\(dm.all.count) Transactions")
                    Spacer()
                    NavigationLink(destination: AllTransacitonsView(), label: {
                        HStack{
                            Text("View All")
                            Image(systemName: "chevron.right")
                        }
                        
                    })
                }
            }
        }
        .onAppear(perform: {
            UITableView.appearance().contentInset.top = -35
        })
        .padding()
    }
    
    
    var HomeSummary: some View {
        VStack(alignment: .leading, spacing: 20) {
            
            VStack(alignment: .leading) {
                Text("Spent Today")
                    .font(.system(size: 30, weight: .regular, design: .default))
                    .opacity(0.5)
                Text("$\(spentToday, specifier: "%.2f")")
                    .font(.system(size: 35, weight: .regular, design: .rounded))
            }
            VStack(alignment: .leading) {
                Text("Top Category")
                    .font(.headline)
                    .opacity(0.5)
                Text(topCat)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
            VStack(alignment: .leading) {
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text(topPayment)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .clipped()
    }
}

//MARK: Computed Properties returning data.

extension HomeView {
    
    var spentToday: Double {
        var total = 0.0
        
        for transaction in dm.today {
            total += transaction.amount
        }
        
        return total
    }
    
    var topCat: String {
        var arry: [String] = []
        
        for transaction in dm.all {
            arry.append(transaction.category ?? "")
            
        }
        
        return arry.filtered().first ?? "No Category Recorded"
    }
    
    var topPayment: String {
        var arry: [String] = []
        
        for transaction in dm.all {
            arry.append(transaction.bank ?? "")
        }
        
        return arry.filtered().first ?? "No Payment Recorded"
    }
}
