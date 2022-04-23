//
//  AllTransacitonsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/21/22.
//

import SwiftUI

struct AllTransacitonsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject private var dm = CoreDataHandler.shared
    @ObservedObject private var vm = AllTransactionsViewModel()
    
    @State private var page: s = .today
    @State private var isPresented: Bool = false
    
    private enum s: Hashable {
        case today
        case seven
        case month
        case year
    }
    
    private var status: String {
        
        switch page {
        case .today:
            return "Today's Transactions"
        case .seven:
            return "Last 7 Days"
        case .month:
            return "This Month"
        case .year:
            return "This Year"
            
        }
        
    }
    
    var body: some View {
        
        VStack {
            Picker("", selection: $page) {
                Text("Today (\(dm.today.count))")
                    .tag(s.today)
                Text("7 Days (\(dm.week.count))")
                    .tag(s.seven)
                Text("Month (\(dm.month.count))")
                    .tag(s.month)
                Text("All")
                    .tag(s.year)
            }
            .pickerStyle(.segmented)
            .padding([.top, .horizontal])
            
            NavigationView {
                
                VStack {
                    TabView (selection: $page) {
                        
                        today
                            .tag(s.today)
                        week
                            .tag(s.seven)
                        month
                            .tag(s.month)
                        year
                            .tag(s.year)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        self.mode.wrappedValue.dismiss()
                    } label: {
                        HStack {
                            Image(systemName: "chevron.left")
                            Text("Home")
                        }
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(status)
            
        }
        .sheet(isPresented: $isPresented) {
            AddTransactionView()
        }
        
        
        
    }
    
}

extension AllTransacitonsView {
    
    var today: some View {
        
        
        List {
            ForEach(dm.today) { t in
                RowView(
                    item: t.name ?? "",
                    date: vm.convertDate(date: t.date ?? Date()),
                    amount: t.amount,
                    category: t.category ?? "")
            }
        }
        
    }
    
    var week: some View {
        
        
        List {
            ForEach(dm.week) { t in
                RowView(
                    item: t.name ?? "",
                    date: vm.convertDate(date: t.date ?? Date()),
                    amount: t.amount,
                    category: t.category ?? "")
            }
        }
        
        
    }
    
    var month: some View {
        
        
        List {
            ForEach(dm.month) { t in
                RowView(
                    item: t.name ?? "",
                    date: vm.convertDate(date: t.date ?? Date()),
                    amount: t.amount,
                    category: t.category ?? "")
            }
        }
        
        
    }
    
    var year: some View {
        Text("This Year")
    }
    
}

