//
//  LocationSettingsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/10/22.
//

import SwiftUI

struct LocationSettingsView: View {
    
    @EnvironmentObject var locationHandler: LocationsHandler
    
    private var authorizationState: Color {
        switch locationHandler.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            return .themeThree
        case .denied, .notDetermined, .restricted:
            return .red
        default:
            return .orange
        }
    }
    
    var body: some View {
        NavigationLink {
            List {
                Section {
                    HStack {
                        Text("Location Tracking")
                        
                        Spacer()
                        
                        Label("\(locationHandler.authorizationMessage)", systemImage: "location.viewfinder")
                            .foregroundColor(.themeThree)

                    }
                } footer: {
                    VStack(spacing: 5) {
                        Text("When location is enabled, the app takes a snapshot of your current location when adding a transaction and stores the coordinates along with the transaction information, then the only time when the location is used is when the transaction has been recent and shown in the Home page.")
                    }
                    
                }
                
                Section(header: Text("Legend")) {
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Label("When in Use", systemImage: "location.viewfinder")
                            .foregroundColor(authorizationState)
                        Text("The app has permission to use location, when app is only on use.")
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Label("At All Times", systemImage: "location.viewfinder")
                            .foregroundColor(authorizationState)
                        Text("The app has permission to use location at all times.")
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Denied", systemImage: "location.viewfinder")
                            .foregroundColor(authorizationState)
                        Text("The app has been denied to use location services for transactions")
                    }
                    
                }
            }
        } label: {
            Text("Location")
        }
    }
}
