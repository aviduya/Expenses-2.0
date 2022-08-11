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
                            BankSettingsView()
                        }
                        HStack {
                            Image(systemName: "checklist")
                                .appSettingsListStyle(color: .green)
                            Divider()
                            CategorySettingsView()
                        }
                        
                        HStack {
                            Image(systemName: "slider.horizontal.below.rectangle")
                                .appSettingsListStyle(color: .teal)
                            Divider()
                            ThresholdSettingView()
                        }
                        
                        HStack {
                            Image(systemName: "location.fill.viewfinder")
                                .appSettingsListStyle(color: .red)
                            Divider()
                            LocationSettingsView()
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
