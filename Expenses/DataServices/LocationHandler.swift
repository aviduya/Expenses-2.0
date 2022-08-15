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
    
    @Published var lastSeenLocation: CLLocation?
    @Published var currentPlacemark: CLPlacemark?
    
    @Published var authorizationStatus: CLAuthorizationStatus
    private let locationManager = CLLocationManager()
    
    private override init() {
        authorizationStatus = locationManager.authorizationStatus
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    var authorizationMessage: String {
        switch authorizationStatus {
        case .authorizedAlways:
            return "All Times"
        case .authorizedWhenInUse:
            return "When in use"
        case .denied:
            return "Denied"
        case .notDetermined:
            return "Not Determined"
        case .restricted:
            return "Restricted"
        default:
            return "Error, Something has gone wrong."
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
