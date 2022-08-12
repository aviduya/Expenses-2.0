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
                        
                        banks
                        
                        category
                        
                        threshold
                        
                        loation
    
                    } header: {
                        Text("Primary Settings")
                    }
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

extension AppSettingsView {
    
    var banks: some View {
        HStack {
            Image(systemName: "building.columns")
                .appSettingsListStyle(color: .orange)
            Divider()
            BankSettingsView()
        }
    }
    
    var category: some View {
        HStack {
            Image(systemName: "checklist")
                .appSettingsListStyle(color: .green)
            Divider()
            CategorySettingsView()
        }
    }
    
    var threshold: some View {
        HStack {
            Image(systemName: "slider.horizontal.below.rectangle")
                .appSettingsListStyle(color: .teal)
            Divider()
            ThresholdSettingView()
        }
    }
    
    var loation: some View {
        HStack {
            Image(systemName: "location.fill.viewfinder")
                .appSettingsListStyle(color: .red)
            Divider()
            LocationSettingsView()
        }
    }
    
}
