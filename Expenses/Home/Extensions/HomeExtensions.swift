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
    
    //MARK: List view of 5 Recent transactions.
    
    var HomeList: some View {
        ScrollView {
                Section {
                    ForEach(dm.all.prefix(5)) { t in
                        RowView(
                            entity: t,
                            entities: $dm.all,
                            onDelete: dm.deleteTransactions(_:),
                            item: t.name ?? "",
                            date: t.date?.formatted() ?? "Something went wrong",
                            amount: t.amount,
                            category: t.category ?? "")
                    }
                }
        }
    }
    
    //MARK: Navigation header responsible for navigating to AllTransactionsView()
    
    var HomeNavigation: some View {
        HStack {
            Text("5 Most recent transactions")
                .bold()
                .opacity(0.63)
            Spacer()
            Button {
                isPresentedAll.toggle()
            } label: {
                HStack {
                    
                    Text("View All")
                    Image(systemName: "chevron.down")
                }
            }
            
        }.padding(.top, 10)
    }
    
    //MARK: SummaryView() of SpentToday, TopCategory, TopBank
    
    var HomeSummary: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            VStack(alignment: .leading) {
                
                Text("Spent Today")
                    .font(.system(size: 30, weight: .regular, design: .default))
                    .opacity(0.5)
                
            }
            HStack(alignment: .center) {
                Text("$\(spentToday, specifier: "%.2f")")
                    .redacted(reason: dm.all.isEmpty ? .placeholder : [])
                    .shimmering(active: dm.all.isEmpty)
                    .font(.system(size: 35, weight: .regular, design: .rounded))
                Spacer()
                if diffPercentage > 0 {
                    
                    HStack {
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(Color.red)
                        Text("\(diffPercentage.rounded(), specifier: "%2.f")%")
                    }
                    .font(.system(size: 20, weight: .bold, design: .default))
                } else if diffPercentage < 0 {
                    HStack {
                        Image(systemName: "arrow.down.right")
                            .foregroundColor(Color.green)
                        Text("\(diffPercentage.rounded(), specifier: "%2.f")%" )
                        
                    }
                    .font(.system(size: 20, weight: .bold, design: .default))
                }

            }
            VStack(alignment: .leading) {
                Text("Top Category")
                    .font(.headline)
                    .opacity(0.5)
                Text(topCat)
                    .redacted(reason: dm.all.isEmpty ? .placeholder : [])
                    .shimmering(active: dm.all.isEmpty)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
            VStack(alignment: .leading) {
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text(topPayment)
                    .redacted(reason: dm.all.isEmpty ? .placeholder : [])
                    .shimmering(active: dm.all.isEmpty)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
                
            }
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }
}

//MARK: Computed Properties returning data -> HomeSummary().

extension HomeView {
    
    var spentToday: Double {
        
        var total = 0.0
        
        for transaction in dm.today {
            total += transaction.amount
        }
        
        return total
    }
    
    var spentYesterday: Double {
        
        var total = 0.0
        
        if dm.yesterday.isEmpty {
            total = 1.0
        } else {
            for transaction in dm.yesterday {
                total += transaction.amount
            }
        }
        return total
    }
    
    var diffPercentage: Double {
        let difference = spentToday - spentYesterday
        if dm.yesterday.isEmpty && dm.today.isEmpty {
            return 0.0
        } else {
            return (difference / spentYesterday) * 100.099
            
        }
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



