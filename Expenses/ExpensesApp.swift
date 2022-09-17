//
//  ExpensesApp.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/24/21.
//

import SwiftUI
import CoreLocation

@main
struct ExpensesApp: App {
    @Environment(\.scenePhase) var scenePhase

    @StateObject private var settings = AppSettingsViewModel()
    @StateObject private var dataHandler: CoreDataHandler = .shared
    @StateObject private var locationHandler: LocationsHandler = .shared

    
    var body: some Scene {
        WindowGroup {
            DashboardView()
                .preferredColorScheme(.dark)
                .environmentObject(settings)
                .environmentObject(dataHandler)
                .environmentObject(locationHandler)
//                HomeView()
//                    .preferredColorScheme(.dark)
//                    .environmentObject(settings)
//                    .environmentObject(dataHandler)
//                    .environmentObject(locationHandler)
        }
        .onChange(of: scenePhase) { newScenePhase in
            switch newScenePhase {
            case .active:
                print("App is active")
            case .inactive:
                print("App is inactive")
            case .background:
                print("App is in background")
            @unknown default:
                print("Oh - interesting: I received an unexpected new value.")
            }
        }
        
    }
}
