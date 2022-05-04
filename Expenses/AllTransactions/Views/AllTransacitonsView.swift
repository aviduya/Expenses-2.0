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
    @StateObject private var vm = AllTransactionsViewModel()
    
    private let error = "Something went wrong"
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(vm.status)
                        .font(Font.system(.title2, design: .default).weight(.bold))
                    Spacer()
                    Button {
                        mode.wrappedValue.dismiss()
                    } label: {
                        Text("Dismiss")

                    }

                }
                
                ScrollView {
                    VStack {
                        switch vm.page {
                        case .today:
                            today
                        case .seven:
                            week
                        case .month:
                            month
                        case .year:
                            year
                        }
                    }
                    
                }
                
                HStack {
                    EditButton()
                    Spacer()
                    
                    Menu {
                        Section {
                            Picker("Sort by", selection: $vm.page) {
                                
                                HStack {
                                    Text("Today [\(dm.today.count)]")
                                }
                                .tag(selectedFilter.today)
                                
                                HStack {
                                    Text("7 Days [\(dm.week.count)]")
                                }
                                .tag(selectedFilter.seven)
                                
                                HStack {
                                    Text("Month [\(dm.month.count)]")
                                }
                                .tag(selectedFilter.month)
                                
                                HStack {
                                    Text("All Transactions [\(dm.all.count)]")
                                }
                                .tag(selectedFilter.year)
                            }
                        }
                    } label: {
                        Image(systemName: "square.stack.3d.up.fill")
                            .font(.title3)
                    }
                }
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
        }
        .padding([.top, .leading, .trailing], 20)
        }
        
    }



extension AllTransacitonsView {
    
    var today: some View {
        
        VStack {
            if dm.today.isEmpty {
                EmptyView()
            }
            ForEach(dm.today) { t in
                RowView(
                    entity: t,
                    entities: $dm.all,
                    onDelete: dm.deleteTransactions(_:),
                    item: t.name ?? "",
                    date: t.date?.formatted() ?? error,
                    amount: t.amount,
                    category: t.category ?? "")
        }
        
        }
    }
    
    var week: some View {
        
        VStack {
            if dm.week.isEmpty {
                EmptyView()
            }
            ForEach(dm.week) { t in
                RowView(
                    entity: t,
                    entities: $dm.all,
                    onDelete: dm.deleteTransactions(_:),
                    item: t.name ?? "",
                    date: t.date?.formatted() ?? error,
                    amount: t.amount,
                    category: t.category ?? "")
        }
        }
    }
    
    var month: some View {
        VStack {
            if dm.month.isEmpty {
                EmptyView()
            }
            ForEach(dm.month) { t in
                RowView(
                    entity: t,
                    entities: $dm.all,
                    onDelete: dm.deleteTransactions(_:),
                    item: t.name ?? "",
                    date: t.date?.formatted() ?? error,
                    amount: t.amount,
                    category: t.category ?? "")
            }
        }
    }
    
    var year: some View {
        
        VStack {
            if dm.all.isEmpty {
                EmptyView()
            }
            ForEach(dm.all) { t in
                RowView(
                    entity: t,
                    entities: $dm.all,
                    onDelete: dm.deleteTransactions(_:),
                    item: t.name ?? "",
                    date: t.date?.formatted() ?? error,
                    amount: t.amount,
                    category: t.category ?? "")
            }
        }
        
       
    }
}


