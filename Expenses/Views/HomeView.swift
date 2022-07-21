//
//  HomeView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/8/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var settings: AppSettingsViewModel
    @ObservedObject var vm = HomeViewModel()
    @StateObject var dm = CoreDataHandler.shared
    
    @State var activeSheet: ActiveView?
    
    var body: some View {
        
        // Most of the View components are extracted into HomeExtensions.swift for clarity.
        
        VStack {
            VStack(alignment: .leading) {
                Text(Date().returnTitleString())
                    .font(.body)
                    .bold()
                    .opacity(0.66)
                Text(vm.greeting)
                    .font(Font.system(.largeTitle, design: .default).weight(.bold))
                
                // This is responsible for checking if transactions are empty, if it is show the EmptyView()
                HomeSummary
                    .padding(.top, 10)
                if dm.all.isEmpty {
                    EmptyView()
                } else {
                    HomeNavigation
                    HomeList
                }
                
                // Bottom Bar that includes Adding a transaction and settings.
               HomeBottomBar
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding([.top, .leading, .trailing], 20)
        
        /// This sheet is responsible for navigation to all of the pages that the user can navigate from the HomeView()
        /// When dismissed it calls upon the CoreDataHandler() method to fetch and appends all transactions to their respective formats.
        
        .sheet(item: $activeSheet, onDismiss: { }) { item in
            switch item {
            case .all:
                AllTransacitonsView()
            case .settings:
                AppSettingsView()
            case .add:
                AddTransactionView()
            }
        }
    }
    
    var HomeList: some View {
        ScrollView {
                Section {
                    ForEach(dm.all.prefix(5)) { data in
                        RowView(
                            entity: data,
                            entities: $dm.all,
                            onDelete: dm.deleteTransactions(_:),
                            item: data.name ?? "",
                            date: data.date ?? Date(),
                            amount: data.amount,
                            category: data.category ?? "")
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
                activeSheet = .all
                settings.haptic(style: .medium)
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
                Text("$\(vm.spentToday, specifier: "%.2f")")
                    .redacted(reason: dm.all.isEmpty ? .placeholder : [])
                    .shimmering(active: dm.all.isEmpty)
                    .font(.system(size: 35, weight: .regular, design: .rounded))
                Spacer()
                if vm.diffPercentage > 0 {
                    
                    HStack {
                        Image(systemName: "arrow.up.right")
                            .foregroundColor(Color.red)
                        Text("\(vm.diffPercentage.rounded(), specifier: "%2.f")%")
                    }
                    .font(.system(size: 20, weight: .bold, design: .default))
                } else if vm.diffPercentage < 0 {
                    HStack {
                        Image(systemName: "arrow.down.right")
                            .foregroundColor(Color.green)
                        Text("\(vm.diffPercentage.rounded(), specifier: "%2.f")%" )
                        
                    }
                    .font(.system(size: 20, weight: .bold, design: .default))
                }

            }
            VStack(alignment: .leading) {
                Text("Top Category")
                    .font(.headline)
                    .opacity(0.5)
                Text(vm.topCat)
                    .redacted(reason: dm.all.isEmpty ? .placeholder : [])
                    .shimmering(active: dm.all.isEmpty)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
            }
            VStack(alignment: .leading) {
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text(vm.topPayment)
                    .redacted(reason: dm.all.isEmpty ? .placeholder : [])
                    .shimmering(active: dm.all.isEmpty)
                    .font(Font.system(.largeTitle, design: .default).weight(.medium))
                
            }
        }
        .frame(maxWidth: .infinity)
        .clipped()
    }
    
    var HomeBottomBar: some View {
        HStack {
            Menu {
                Section {
                    EditButton()
                        .disabled(dm.all.isEmpty)
                }
                Section {
                    Button(action: {
                        activeSheet = .settings
                    }) {
                        Label("Settings", systemImage: "person.text.rectangle")
                    }
                }
            } label: {
                Image(systemName: "bolt.fill")
            }
            Spacer()
            Button(action: {
                activeSheet = .add
                settings.haptic(style: .heavy)
            }) {
                Label("Add", systemImage: "plus")
            }
        }
        .font(.title3)
    }
    
}
