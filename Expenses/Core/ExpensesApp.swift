//
//  ExpensesApp.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/24/21.
//

import SwiftUI

@main
struct ExpensesApp: App {
    @Environment(\.scenePhase) var scenePhase
    
    let settings = AppSettings()
    let data = CoreDataHandler.shared
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environmentObject(settings)
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
