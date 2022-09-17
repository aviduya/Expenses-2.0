//
//  DashboardView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 9/11/22.
//

import SwiftUI
import CoreLocation

struct DashboardView: View {
    
    @EnvironmentObject private var location: LocationsHandler
    @EnvironmentObject private var data: CoreDataHandler
    @StateObject private var viewModel = DashboardViewModel()
    
    @State private var selectedPage: Destinations?
    @State private var didViewAppear: Bool = false
    @State private var selectedTab: Int = 1
    
    private enum Destinations: Identifiable {
        
        var id: Int {
            hashValue
        }
        
        case all
        case add
        case settings
    }
    
    var body: some View {
        
        GeometryReader { proxy in
            ScrollView(showsIndicators: true) {
                VStack(alignment: .leading) {
                    
                    Group {
                        Text(Date().dateTitle())
                            .font(.callout)
                            .opacity(0.66)
                        HStack {
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(viewModel.greeting.message)
                                        .transition(.move(edge: .bottom))
                                    Image(systemName: viewModel.greeting.symbol)
                                        .symbolRenderingMode(.multicolor)
                                }
                            }
                            Spacer()
                            Button {
                                selectedPage = .settings
                            } label: {
                                Image(systemName: "gearshape.circle")
                                    .foregroundColor(.themeThree)
                            }
                        }
                        .padding(.bottom)
                        .font(.title)
                        .fontWeight(.bold)
                    }
                    
                    
                    VStack(alignment: .leading ,spacing: 20) {
                        Section {
                            DashboardChartView()
                            
                        } header: {
                            HStack {
                                Image(systemName: "chart.xyaxis.line")
                                    .foregroundColor(.themeThree)
                                Text("Trends")
                                    .opacity(0.33)
                            }
                            
                            .font(.footnote)
                            .bold()
                        }
                        
                        
                    }
                    
                    
                }
            }
        }
        .padding(10)
        .sheet(item: $selectedPage, onDismiss: {viewModel.fetchTransactions()}) { page in
            switch page {
            case .all:
                AllTransactionsWeekView()
            case .settings:
                AppSettingsView()
            case .add:
                AddTransactionView()
            }
        }
        .overlay(alignment: .bottom) {
            Button {
                selectedPage = .add
            } label: {
                Text("Add a Transaction")
            }
            .padding()
            .buttonStyle(CustomButtonStyle())
            
        }
        
    }
}

class DashboardViewModel: ObservableObject {
    
    @Published var transactions: [TransactionEntity] = []
    
    private let data: CoreDataHandler = .shared
    private let location: LocationsHandler = .shared
    
    init() {
        fetchTransactions()
        print(transactions)
    }
    
    func fetchTransactions() {
        data.getTransaction(&transactions, debugStatement: "Invoking from: Line 126 in DashboardView()")
        print(transactions.count)
    }
       

    var greeting: (message: String, symbol: String) {
        
        let hour = Calendar.current.component(.hour, from: Date())
        let newDay = 0
        let noon = 12
        let sunset = 18
        let midnight = 24
        
        switch hour {
            
        case newDay ..< noon:
            return ("Good Morning!", "cloud.sun.fill")
        case noon ..< sunset:
            return ("Good Afternoon!", "sun.max.fill")
        case sunset ..< midnight:
            return ("Good Evening!", "moon.stars.fill")
            
        default:
            return ("Error Fetching Date", "exclamationmark.triangle.fill")
        }
        
    }
            
        
    }
    

    

