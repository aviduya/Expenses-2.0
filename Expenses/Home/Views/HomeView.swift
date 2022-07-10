//
//  HomeView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/8/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var settings: AppSettings
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
    
}
