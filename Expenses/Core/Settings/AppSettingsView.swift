//
//  AppSettingsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 5/4/22.
//

import SwiftUI


struct AppSettingsView: View {
    
    @EnvironmentObject var settings: AppSettings
    
    @State var bank: String = ""
    @State var category: String  = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List() {
                    NavigationLink {
                        List {
                            HStack {
                                TextField("Enter a Bank", text: $bank)
                                Spacer()
                                Image(systemName: "plus")
                                    .onTapGesture {
                                        settings.addElement(new: bank, element: &settings.banks, key: settings.bankKey)
                                        
                                        bank = ""
                                    }
                            }
                            ForEach(settings.banks, id: \.self) { i in
                                    Text(i)
                            }
                            .onDelete(perform: settings.removeBank)
                            
                        }
                    } label: {
                        Text("Banks")
                    }
                    NavigationLink {
                        
                        
                        List() {
                            HStack {
                                TextField("Enter a Category", text: $category)
                                Spacer()
                                Image(systemName: "plus")
                                    .onTapGesture {
                                        settings.addElement(new: category, element: &settings.categories, key: settings.categoryKey)
                                        category = ""
                                    }
                            }
                            
                            ForEach(settings.categories, id: \.self) { i in
                                HStack {
                                    Text(i)
                                    Spacer()
                                }
                            }
                            .onDelete(perform: settings.removeCategory)
                            
                        }
                        .toolbar(content: {
                            ToolbarItem {
                                EditButton()
                            }
                        })
                    } label: {
                        Text("Categories")
                    }
                    
                    
                }
                .navigationTitle("Settings")
            }
        }
    }
}
