//
//  ExpensesApp.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/24/21.
//

import SwiftUI
import Sentry

@main
struct ExpensesApp: App {
    @Environment(\.scenePhase) var scenePhase
    @StateObject private var settings = AppSettingsViewModel()
    @StateObject private var dm = CoreDataHandler.shared
    
    // Folding Sentry Initializer.
    /*
        
//    init() {
//        SentrySDK.start { options in
//            //TODO: Hide keys before merging into main branch.
//            options.dsn = "https://6fdb56a518074040a048b811f39e3e73@o1249741.ingest.sentry.io/6410567"
//            options.debug = true // Enabled debug when first installing is always helpful
//            options.enableUIViewControllerTracking = true
//            options.environment = "debug"
//
//                    // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
//                    // We recommend adjusting this value in production.
//            options.tracesSampleRate = 1.0
//
//            options.enableAutoPerformanceTracking = true
//            options.enableCoreDataTracking = true
//            }
//
//        // Transaction can be started by providing, at minimum, the name and the operation
//        let transaction = SentrySDK.startTransaction(name: "Debug Transactions", operation: "db")
//        // Transactions can have child spans (and those spans can have child spans as well)
//        let span = transaction.startChild(operation: "db", description: "Update first repo")
//
//        // ...
//        // (Perform the operation represented by the span/transaction)
//        // ...
//
//        span.finish() // Mark the span as finished
//        transaction.finish() // Mark the transaction as finished and send it to Sentry
//
//    }
     */
    
    var body: some Scene {
        WindowGroup {
                HomeView()
                    .environmentObject(settings)
                    .environmentObject(dm)
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
