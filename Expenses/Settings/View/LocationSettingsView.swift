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
                        
                        Label("\(locationHandler.authorizationState)", systemImage: locationHandler.isAuthorized ? "location.viewfinder" : "location.slash")
                            .foregroundColor(locationHandler.isAuthorized ? .themeThree : .red)

                    }
                } footer: {
                    VStack(spacing: 5) {
                        Text("When location is enabled, the app takes a snapshot of your current location when adding a transaction and stores the coordinates along with the transaction information, then the only time when the location is used is when the transaction has been recent and shown in the Home page, to change location permissions,")
                        Text("Settings > Expn.se > Location")
                    }
                  
                    
                }
                
                Section(header: Text("Legend")) {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Allowed", systemImage: "location.viewfinder")
                            .foregroundColor(.themeThree)
                        Text("The app has permission to use location, when adding transactions only.")
                    }
                    
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Label("Denied", systemImage: "location.slash")
                            .foregroundColor(.red)
                        Text("The app has been denied to use location tracking.")
                    }
   
                }
            }
        } label: {
            Text("Location")
        }
    }
}
