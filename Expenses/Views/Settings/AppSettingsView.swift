//
//  AppSettingsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 5/4/22.
//

import SwiftUI

struct AppSettingsView: View {
    
    @EnvironmentObject var settings: AppSettingsViewModel
    @EnvironmentObject var locationHandler: LocationsHandler
    @Environment(\.dismiss) var dismiss
    
    @State private var userValueThreshold: Double = 0.0
    @State private var bank: String = ""
    @State private var category: String  = ""
    
    let material: Material = .thin
    
    init() {
        UITextView.appearance().backgroundColor = .clear
    }
    
    // MARK: Main view
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section {
                        HStack {
                            Image(systemName: "building.columns")
                                .appSettingsListStyle(color: .orange)
                            Divider()
                            bankList
                        }
                        HStack {
                            Image(systemName: "checklist")
                                .appSettingsListStyle(color: .green)
                            Divider()
                            categoryList
                        }
                        
                        HStack {
                            Image(systemName: "slider.horizontal.below.rectangle")
                                .appSettingsListStyle(color: .teal)
                            Divider()
                            threshold
                            
                        }
                        
                        HStack {
                            Image(systemName: "location.fill.viewfinder")
                                .appSettingsListStyle(color: .red)
                            Divider()
                            locationSetting
                        }
                        
                    } header: {
                        Text("Primary Settings")
                    }
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}


// MARK: App Settings View extension.

extension AppSettingsView {
    
    // MARK: Bank List view from navigation.
    
    var bankList: some View {
        NavigationLink {
            List {
                Section {
                    HStack {
                        TextField("Add a Bank", text: $bank)
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                settings.addElement(new: bank, element: &settings.banks, key: settings.bankKey)
                                bank = ""
                            }
                            .disabled(bank.isEmpty)
                    }
                    
                } footer: {
                    Text("A list of accounts that are displayed when adding a transaction.")
                }
                
                Section {
                    ForEach(settings.banks, id: \.self) { i in
                        Text(i)
                    }
                    .onDelete(perform: settings.removeBank)
                } header: {
                    HStack {
                        Image(systemName: "building.columns")
                            .foregroundColor(.orange)
                        Text("Active Accounts")
                    }
                }
                
            }
        } label: {
            Text("Banks")
        }
    }
    
    
    // MARK: Category list view from navigation view
    
    var categoryList: some View {
        
        NavigationLink {
            List {
                Section {
                    HStack {
                        TextField("Enter a Category", text: $category)
                        Spacer()
                        Image(systemName: "plus")
                            .foregroundColor(.blue)
                            .onTapGesture {
                                settings.addElement(new: category, element: &settings.categories, key: settings.categoryKey)
                                category = ""
                            }
                            .disabled(category.isEmpty)
                    }
                    
                } footer: {
                    Text("A list of category that is associated with the transaction.")
                }
                
                Section {
                    ForEach(settings.categories, id: \.self) { i in
                        HStack {
                            Text(i)
                            Spacer()
                        }
                    }
                    .onDelete(perform: settings.removeCategory)
                } header: {
                    HStack {
                        Image(systemName: "checklist")
                            .foregroundColor(.green)
                        Text("Active Categories")
                    }
                    
                }
                
            }
        } label: {
            Text("Categories")
        }
    }
    
    // MARK: Threshold view from navigation view.
    
    var threshold: some View {
        NavigationLink {
            VStack {
                
                Text("$\(settings.userValueTreshold, specifier: "%.2f")")
                    .font(.system(size: 60, weight: .bold, design: .rounded))
                
                
                Divider()
                
                Section {
                    HStack{
                        TextField  ("\(settings.userValueTreshold)", value: $userValueThreshold, format: .currency(code: "usd"))
                        Spacer()
                        Button {
                            settings.setUserValueThreshold(value: userValueThreshold)
                        } label: {
                            Text("Set")
                        }
                        
                    }
                    .padding()
                    .background(material, in: RoundedRectangle(cornerRadius: 16))
                } header: {
                    
                    HStack {
                        Text("Set Amount threshold.")
                            .font(.subheadline)
                            .opacity(0.33)
                        Spacer()
                    }
                    
                }
                
                Section {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        
                        HStack {
                            Text("$\(settings.belowValueThreshold, specifier: "%.2f")")
                                .appSettingsThresholdStyle(primary: .primaryGreen, secondary: .secondaryGreen)
                            
                            VStack(alignment: .trailing) {
                                Image(systemName: "arrow.backward")
                                Text("Less Than")
                            }
                            .font(.title2)
                        }
                        
                        HStack {
                            Text("$\(settings.aboveValueThreshold, specifier: "%.2f")")
                                .appSettingsThresholdStyle(primary: .primaryOrange, secondary: .secondaryOrange)
                        
                            VStack(alignment: .trailing) {
                                Image(systemName: "arrow.left.arrow.right")
                                Text("Range of")
                            }
                            .font(.title2)
                        }
                        
                        HStack(spacing: 10) {
                            Text("$\(settings.rangeOfValueThreshold, specifier: "%.2f")")
                                .appSettingsThresholdStyle(primary: .primaryRed, secondary: .secondaryRed)
                        
                            VStack(alignment: .center) {
                                Image(systemName: "arrow.right")
                                Text("Greater than")
                            }
                            .font(.title2)
                        }
                        
                    }
                    .padding()
                    .background(material, in: RoundedRectangle(cornerRadius: 16))
                } footer: {
                    HStack {
                        Text("These colors computes the amount that was set to three tiers of spending amount. Good, Warning and Extreme to the amount that is set .")
                            .fixedSize(horizontal: false, vertical: true)
                            .font(.subheadline)
                            .opacity(0.33)
                        Spacer()
                    }
                }
            }.padding()
        } label: {
            Text("Threshold")
        }
    }
    
    var locationSetting: some View {
        
        NavigationLink {
            List {
                Section {
                    VStack {
                        Button {
                            locationHandler.requestPermission()
                        } label: {
                            Text("Allow Location Tracking")
                        }
                        
                    }
                    
                } footer: {
                    
                }
                Text("\(locationHandler.authorizationMessage)")
            }
        } label: {
            Text("Location")
        }
    }
    
}
