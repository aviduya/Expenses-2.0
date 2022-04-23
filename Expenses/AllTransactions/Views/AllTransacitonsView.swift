//
//  AllTransacitonsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/21/22.
//

import SwiftUI
import Expenses_UI_Library

struct AllTransacitonsView: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject private var vm = AllTransactionsViewModel()
    
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
                Text("Today")
                    .tag(s.today)
                Text("Last 7 Days")
                    .tag(s.seven)
                Text("Month")
                    .tag(s.month)
                Text("Year")
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
            ForEach(vm.today) { t in
                RecentRowView(
                    item: t.name ?? "",
                    date: vm.convertDate(date: t.date ?? Date()),
                    amount: t.amount,
                    category: t.category ?? "")
            }
        }
        
    }
    
    var week: some View {
        
        
        List {
            ForEach(vm.week) { t in
                RecentRowView(
                    item: t.name ?? "",
                    date: vm.convertDate(date: t.date ?? Date()),
                    amount: t.amount,
                    category: t.category ?? "")
            }
        }
        
        
    }
    
    var month: some View {
        
        
        List {
            ForEach(vm.month) { t in
                RecentRowView(
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

struct Badge: View {
    let count: Int

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear
            Text(String(count))
                .font(.system(size: 16))
                .padding(5)
                .background(Color.red)
                .clipShape(Circle())
                // custom positioning in the top-right corner
                .alignmentGuide(.top) { $0[.bottom] }
                .alignmentGuide(.trailing) { $0[.trailing] - $0.width * 0.25 }
        }
    }
}
