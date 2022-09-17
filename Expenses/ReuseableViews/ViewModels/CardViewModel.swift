//
//  CardViewModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 8/16/22.
//

import Foundation
import MapKit

final class CardViewModel: ObservableObject {
    
    @Published private(set) var viewAdress: String = ""


    func formatDate(_ userInput: Date) -> String {
        
        
        let input = Calendar.current.dateComponents([.day], from: userInput)
        let dateTo = Calendar.current.dateComponents([.day], from: Date())
        let yesterday = Calendar.current.dateComponents([.day], from: Date().getYesterday() ?? Date())
        
        if input == dateTo {
            return "Today"
        } else if input == yesterday {
            return  "Yesterday"
        }
        
        return userInput.formatted()
        
    }
    
    func getAddress(location: CLLocationCoordinate2D) {
        let location = CLLocation(latitude: location.latitude, longitude: location.longitude)
        
        location.placemark { placemark, error in
            guard let placemark = placemark else {
                print("Error: ", error ?? "nil")
                return
            }
            self.viewAdress = (placemark.streetNumber ?? "") + " " + (placemark.streetName ?? "") + ", " + (placemark.city ?? "") + ", " + (placemark.state ?? "")
        }
    }
    
}
