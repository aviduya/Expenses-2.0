//
//  ExpensesApp.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/24/21.
//

import SwiftUI
import Sentry
import CoreLocation

@main
struct ExpensesApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var settings = AppSettingsViewModel()
    @StateObject private var dm = CoreDataHandler.shared
    @StateObject private var location = LocationsHandler()

    
    var body: some Scene {
        WindowGroup {
                HomeView()
                    .environmentObject(settings)
                    .environmentObject(dm)
                    .environmentObject(location)
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
