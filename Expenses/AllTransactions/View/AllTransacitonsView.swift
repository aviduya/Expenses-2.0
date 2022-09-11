//
//  AllTransacitonsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/21/22.
//

import SwiftUI

protocol FormatableDates {
    
    func month(input: Date) -> String
}

struct AllTransacitonsView: View, FormatableDates {

    func month(input: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM"
        let month = dateFormatter.string(from: input )
        
        return month
    }
    
    
    @EnvironmentObject var settings: AppSettingsViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @StateObject private var dm: CoreDataHandler = .shared
    @StateObject private var vm = AllTransactionsViewModel()
    
    @State private var isShowing: Bool = true
    
    private let error = Date()
    private let material: Material = .ultraThinMaterial
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                header
                
                AllTransactionsWeekView()
                
                footer
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        
        .padding([.top, .leading, .trailing])
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
                    withAnimation(.easeInOut(duration: 0.3)) {
                        vm.runRangeRequest()
                        isShowing = false
                    }
                } label: {
                    Text("Set Custom Filter")
                        .foregroundColor(.themeThree)
                }
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
                HStack {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                    
                    Text(vm.status)
                }
                .id("Title" + vm.status)
                .foregroundColor(.themeThree)
                .padding(10)
                .background(material, in: Capsule())
                .shadow(radius: 10)
                
            }
            .transaction { transaction in
                transaction.animation = nil
            }
        }
        .font(.title2)
    }
    
    // MARK: Today List View
    
    var today: some View {
        VStack {
            if dm.today.isEmpty {
                EmptyView(message: "Add a transaction")
            }
            ForEach(dm.today) { t in
                RowView(
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
            
            if dm.week.isEmpty {
                EmptyView(message: "Add a transaction")
            }
            
            AllTransactionsWeekView()
           
        }
    }
    
    // MARK: Month List View
    
    var month: some View {
        VStack {
            
            if dm.month.isEmpty {
                EmptyView(message: "Add a transaction")
            }
            ForEach(dm.month) { t in
                RowView(
                   
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
            VStack {
                HStack {
                    Text("Edit Date Range")
                    Spacer()
                    Image(systemName: isShowing ? "chevron.right.circle.fill" : "chevron.right.circle")
                        .font(.system(size: 20))
                        .foregroundColor(.themeThree)
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                isShowing.toggle()
                            }
                        }
                        .rotationEffect(.degrees(
                            isShowing ? 90 : 0
                        ))
                }
                
                if isShowing {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        Divider()
                        
                        DatePicker("Start", selection: $vm.startDate, in: ...Date(), displayedComponents: .date)
                        
                        DatePicker("End", selection: $vm.endDate, in: ...Date(), displayedComponents: .date)
                        
                        
                    }
                }
            }
            .padding()
            .background(material, in: RoundedRectangle(cornerRadius: 14))
            
            ForEach(vm.headers, id: \.self) { header in
                Section {
                    ForEach(vm.groupedByDate[header]!) { t in
                        RowView(
                            item: t.name ?? "",
                            date: t.date ?? error,
                            amount: t.amount,
                            category: t.category ?? "")
                    }
                } header: {
                    HStack {
                        Text("\(month(input: header))")
                            .bold()
                        Spacer()
                    }
                }
                
            }
        }
    }
}

