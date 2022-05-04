//
//  HomeView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/8/22.
//

import SwiftUI

struct HomeView: View {
    
    
    @ObservedObject var vm = HomeViewModel()
    @StateObject var dm = CoreDataHandler.shared
    
    @State  var isPresentedAdd: Bool = false
    @State  var isPresentedAll: Bool = false
    
    var body: some View {
        
        VStack {
            VStack(alignment: .leading) {
                Text(Date().formatted())
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
                            
                        }
                        Section {
                            Button(action: { }) {
                                Label("Settings", systemImage: "person.text.rectangle")
                            }
                        }
                        
                    } label: {
                        Image(systemName: "bolt.fill")
                            
                    }
                    
                    Spacer()
                    
                    Button(action: { isPresentedAdd.toggle() }) {
                        Label("Add", systemImage: "plus")
                    }
                    
                    
                    
                }
                .font(.title3)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
        }
        .padding([.top, .leading, .trailing], 20)
        .sheet(isPresented: $isPresentedAdd, onDismiss: { dm.getEverything() }) {
            AddTransactionView()
        }
        .sheet(isPresented: $isPresentedAll, onDismiss: { dm.getEverything() }) {
            AllTransacitonsView()
        }
    }
    
}
