//
//  AllTransacitonsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/21/22.
//

import SwiftUI

struct AllTransacitonsView: View {
    @EnvironmentObject var settings: AppSettingsViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject private var dm = CoreDataHandler.shared
    @StateObject private var vm = AllTransactionsViewModel()
    
    private let error = Date()
    private let material: Material = .ultraThinMaterial
    
    var body: some View {
        NavigationView {
            VStack {
                VStack(alignment: .leading) {
                    header
                    
                    if dm.all.isEmpty {
                        EmptyView()
                    } else {
                        scrollBody
                    }
                    
                    footer
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            }
        }
        .padding([.top, .leading, .trailing], 20)
    }
}

// MARK: Extension of AllTransactionView()

extension AllTransacitonsView {
    
    // MARK: Header of View
    
    var header: some View {
        HStack(alignment: .center) {
            Text(vm.status)
                .font(Font.system(.title2, design: .default).weight(.bold))
            Spacer()
            if vm.page == .custom {
                Button {
                    vm.runRangeRequest()
                } label: {
                    Text("Set Custom Filter")
                        .foregroundColor(.themeThree)
                }
            } else {
                EditButton()
                    .foregroundColor(.themeThree)
            }
            
            
        }
    }
    
    // MARK: Scrolling Body
    
    var scrollBody: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                switch vm.page {
                case .today:
                    today
                case .seven:
                    week
                case .month:
                    month
                case .custom:
                    custom
                }
            }
            
        }
    }
    
    // MARK: Footer
    
    var footer: some View {
        HStack {
            Spacer()
            Menu {
                Section {
                    Picker("Sort by", selection: $vm.page) {
                        
                        HStack {
                            Text("Today")
                        }
                        .tag(vm.filter.today)
                        
                        HStack {
                            Text("Last 7 Days")
                        }
                        .tag(vm.filter.seven)
                        
                        HStack {
                            Text("Current Month")
                        }
                        .tag(vm.filter.month)
                        
                        HStack {
                            Text("Custom")
                        }
                        .tag(vm.filter.custom)
                    }
                }
            } label: {
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .foregroundColor(.themeThree)
                    .padding(10)
                    .background(material, in: Circle())
            }
        }
        .font(.title2)
    }
    
    // MARK: Today List View
    
    var today: some View {
        VStack {
            ForEach(dm.today) { t in
                RowView(
                    entity: t,
                    entities: $dm.all,
                    onDelete: dm.deleteTransactions(_:),
                    item: t.name ?? "",
                    date: t.date ?? error,
                    amount: t.amount,
                    category: t.category ?? "")
            }
            
        }
    }
    
    // MARK: Week List View
    
    var week: some View {
        VStack {
            ForEach(dm.week) { t in
                RowView(
                    entity: t,
                    entities: $dm.all,
                    onDelete: dm.deleteTransactions(_:),
                    item: t.name ?? "",
                    date: t.date ?? error,
                    amount: t.amount,
                    category: t.category ?? "")
            }
        }
    }
    
    // MARK: Month List View
    
    var month: some View {
        VStack {
            ForEach(dm.month) { t in
                RowView(
                    entity: t,
                    entities: $dm.all,
                    onDelete: dm.deleteTransactions(_:),
                    item: t.name ?? "",
                    date: t.date ?? error,
                    amount: t.amount,
                    category: t.category ?? "")
            }
        }
    }
    
    // MARK: Custom Range List View
    
    var custom: some View {
        VStack {
            
            DatePickerView(date: $vm.startDate)
            DatePickerView(date: $vm.endDate)
            
            ForEach(vm.rangeOfTransactions) { t in
                withAnimation {
                    RowView(
                        entity: t,
                        entities: $dm.all,
                        onDelete: dm.deleteTransactions(_:),
                        item: t.name ?? "",
                        date: t.date ?? error,
                        amount: t.amount,
                        category: t.category ?? "")
                }
                
            }
        }
        
        
    }
}


