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
        VStack {
            VStack(alignment: .leading) {
                
                Text(Date().returnTitleString())
                    .font(.body)
                    .opacity(0.66)
                Text(vm.greeting)
                    .font(Font.system(.largeTitle, design: .default).weight(.bold))
                HomeSummary
                    .padding(.top, 10)
                if dm.all.isEmpty {
                    EmptyView()
                } else {
                    HomeNavigation
                    HomeList
                }
                
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
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding([.top, .leading, .trailing], 20)
        .sheet(item: $activeSheet, onDismiss: { dm.getEverything() }) { item in
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
