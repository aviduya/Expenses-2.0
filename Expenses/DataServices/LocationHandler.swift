//
//  LocationHandler.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/9/22.
//

import Foundation
import CoreLocation

class LocationsHandler: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    static let shared = LocationsHandler()
    
    @Published private(set) var isAuthorized: Bool = false
    @Published private(set) var authorizationState: String = ""
    
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    
    @Published var authorizationStatus: CLAuthorizationStatus
    
    
    private let locationManager = CLLocationManager()
    
    private override init() {
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        authState()
    }
    
    func authState() {
        
        switch authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            isAuthorized = true
            authorizationState = "Allowed"
        case .denied, .notDetermined, .restricted:
            isAuthorized = false
            authorizationState = "Denied"
        default:
            print("Error: Could not get Authorization State")
        }
        
    }
    
    func getSnapshotOfLocation(_ completionHandler: @escaping () -> Void) {
        
        if #available(iOS 16, *) {
            locationManager.startUpdatingLocation()
        } else {
            locationManager.requestLocation()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            completionHandler()
        }
        
        if #available(iOS 16, *) {
            locationManager.stopUpdatingLocation()
        }
    }
    
    
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
             print("error:: \(error.localizedDescription)")
        }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastSeenLocation = locations.first
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}
