//
//  HomeView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/8/22.
//

import SwiftUI
import MapKit

struct HomeView: View {
    
    @EnvironmentObject var settings: AppSettingsViewModel
    @EnvironmentObject var locationHandler: LocationsHandler
    @ObservedObject var vm = HomeViewModel()
    
    @State private var activeSheet: ActiveView?
    @State private var tabCount: Int = 1
    
    let material: Material = .ultraThinMaterial
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                HStack {
                    homeTitle
                    Spacer()
                    settingsMenuSubview
                }
                homeSummarySubview
                recentTransactionsSubview
                Spacer()
            }
            homeBottomBarSubview
            
        }
        .padding(10)
        .sheet(item: $activeSheet) { page in
            switch page {
            case .all:
                AllTransacitonsView()
            case .settings:
                AppSettingsView()
            case .add:
                AddTransactionView()
            case .generator:
                GeneratorView()
            case .repository:
                CoreDataView()
            }
        }
        .onAppear {
            locationHandler.requestPermission()
        }
        
    }
    
}

// MARK: Extension of HomeView()

extension HomeView {
    
    // MARK: Date and Message View
    
    private var homeTitle: some View {
        VStack(alignment: .leading) {
            Text(Date().returnTitleString())
                .font(.body)
                .bold()
                .opacity(0.66)
            Text(vm.homeMessage)
                .foregroundColor(Color.themeThree)
                .font(Font.system(.largeTitle, design: .default).weight(.bold))
        }
    }
    
    //MARK: Summary View
    
    private var homeSummarySubview: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            VStack(alignment: .leading) {
                Text("Spent Today")
                    .font(.system(size: 30, weight: .regular, design: .default))
                    .opacity(0.5)
                
            }
            
            HStack(alignment: .center) {
                Text("$\(vm.todayTransactions, specifier: "%.2f")")
                    .homeSummaryStyle(for: vm.allTransactions.isEmpty)
                Spacer()
                Text(vm.differenceMessage)
                    .foregroundColor(vm.hasNegative ? .green : .red)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Top Category")
                    .font(.headline)
                    .opacity(0.5)
                Text(vm.mostUsedPayment)
                    .homeSummaryStyle(for: vm.allTransactions.isEmpty)
                Text("Most Used payment")
                    .font(.headline)
                    .opacity(0.5)
                Text(vm.mostUsedCategory)
                    .homeSummaryStyle(for: vm.allTransactions.isEmpty)
            }
            
        }
        
    }
    
    // MARK: Recent transactions card view
    
    private var recentTransactionsSubview: some View {
        
        VStack {
            HStack {
                Text("5 Most recent transactions")
                    .bold()
                    .opacity(0.63)
                Spacer()
            }
            .padding(.top, 5)
            
            if vm.allTransactions.isEmpty {
                EmptyView(message: "Add a transaction")
            } else {
                TabView(selection: $tabCount) {
                    ForEach(vm.allTransactions.prefix(5)) { transaction in
                        CardView(
                            item: transaction.name ?? "",
                            date: transaction.date ?? Date(),
                            amount: transaction.amount,
                            category: transaction.category ?? "",
                            merchant: transaction.merchant ?? "",
                            bank: transaction.bank ?? "",
                            region: CLLocationCoordinate2D(latitude: transaction.latitude, longitude: transaction.longitude),
                            long: transaction.longitude,
                            lat: transaction.latitude
                        )
                        .padding(10)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            }
        }
    }
    
    // MARK: Settings Button
    
    private var settingsMenuSubview: some View {
        Menu {
            Section {
                
                Button {
                    activeSheet = .repository
                } label: {
                    Label("Edit Transactions", systemImage: "list.bullet.indent")
                }
                
                Button(action: { activeSheet = .generator } ) {
                    Label("Generate Stats", systemImage: "wand.and.rays")
                }
                
                Button(action: {
                    activeSheet = .settings
                }) {
                    Label("Settings", systemImage: "gear")
                }
            }
        } label: {
            Image(systemName: "ellipsis")
                .font(.system(size: 16, weight: .bold))
                .padding()
                .background(material, in: Circle())
                .foregroundColor(.themeThree)
        }
    }
    
    // MARK: Add transaction button & View All transactions
    
    private var homeBottomBarSubview: some View {
        HStack {
            Button {
                activeSheet = .all
                settings.haptic(style: .medium)
            } label: {
                HStack {
                    Image(systemName: "doc.plaintext.fill")
                    Text("View All")
                }
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.themeThree)
            }
            .padding()
            .background(material, in: RoundedRectangle(cornerRadius: 10))
        
            Button(action: { activeSheet = .add }) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add a transaction")
                }
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.themeThree)
            }
            .padding()
            .background(material, in: RoundedRectangle(cornerRadius: 10))
        }
        .font(.title3)
    }
}
