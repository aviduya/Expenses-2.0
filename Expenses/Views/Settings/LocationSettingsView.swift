//
//  LocationSettingsView.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/10/22.
//

import SwiftUI

struct LocationSettingsView: View {
    
    @EnvironmentObject var locationHandler: LocationsHandler
    
    var body: some View {
        NavigationLink {
            List {
                Section {
                    HStack {
                        Text("Location Tracking")
                        
                        Spacer()
                        
                        HStack {
                            Text(locationHandler.authorizationMessage)
                            Image(systemName: "location.viewfinder")
                        }
                        .foregroundColor(.themeThree)
                    }
                } footer: {
                    VStack(spacing: 5) {
                        Text("When location is enabled, the app takes a snapshot of your current location when adding a transaction and stores the coordinates along with the transaction information, then the only time when the location is used is when the transaction has been recent and shown in the Home page.")
                        
                        Spacer()

                        VStack(alignment: .leading) {
                            Label("When in Use", systemImage: "location.viewfinder")
                            
                            Text("The app has permission to use location, when app is only on use.")
                        }
                        .foregroundColor(.themeThree)
                        
                        VStack(alignment: .leading) {
                            Label("At All Times", systemImage: "location.viewfinder")
                            
                            Text("The app has permission to use location at all times.")
                        }
                        .foregroundColor(.themeThree)
                        
                        VStack(alignment: .leading) {
                            Label("Denied", systemImage: "location.viewfinder")
                            
                            Text("The app has been denied to use location services for transactions")
                        }
                        .foregroundColor(.red)
                    }
                    .multilineTextAlignment(.leading)
                    
                }
            }
        } label: {
            Text("Location")
        }
    }
}

struct LocationSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSettingsView()
    }
}
