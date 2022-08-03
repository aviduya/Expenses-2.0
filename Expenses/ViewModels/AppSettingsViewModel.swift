//
//  AppModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 11/29/21.
//

import Foundation
import SwiftUI
import Sentry

enum HapticStyle {
    case light
    case medium
    case heavy
    case rigid
    
}

class AppSettingsViewModel: ObservableObject {
    
    @Published var banks: [String] = []
    @Published var categories: [String] = []
    @Published var userValueTreshold: Double = 0.0
    @Published var belowValueThreshold: Double = 0.0
    @Published var rangeOfValueThreshold: Double = 0.0
    @Published var aboveValueThreshold: Double = 0.0
    
    let userDefaults = UserDefaults.standard
    
    let bankKey = "bank"
    let categoryKey = "category"
    let thresholdKey = "threshold"
    
    var areOptionsEmpty: Bool {
        if banks.isEmpty && categories.isEmpty {
            return true
        } else {
            return false
        }
    }

    init() {
        
        calculateThresholdValues()
        banks = userDefaults.object(forKey: bankKey) as? [String] ?? []
        categories = userDefaults.object(forKey: categoryKey) as? [String] ?? []
        userValueTreshold =  userDefaults.object(forKey: thresholdKey) as? Double ?? 0.0
    }
    
    func setUserValueThreshold(value: Double) {
        let key = "threshold"
        userDefaults.set(value, forKey: key)
        calculateThresholdValues()
        userValueTreshold =  userDefaults.object(forKey: thresholdKey) as? Double ?? 0.0

    }
    
    func calculateThresholdValues() {
        
        let value = userDefaults.object(forKey: thresholdKey) as? Double ?? 0.0
        
        // Return rangeOfValueThreshold
        rangeOfValueThreshold = value
        
        //Return belowValue
        belowValueThreshold = value / 3
        
        //Return aboveValue
        aboveValueThreshold = value / 2
        
    }
    
    func addElement(new: String, element: inout [String], key: String) {
        withAnimation {
            element.append(new)
            userDefaults.set(element, forKey: key)
        }
        
    }
    
    func removeBank(at offsets: IndexSet) {
        banks.remove(atOffsets: offsets)
        userDefaults.set(banks, forKey: bankKey)
    }
    
    func removeCategory(at offsets: IndexSet) {
        categories.remove(atOffsets: offsets)
        userDefaults.set(categories, forKey: categoryKey)
    }
    
    
    func haptic(style: HapticStyle) {
        let heavy = UIImpactFeedbackGenerator(style: .heavy)
        let soft = UIImpactFeedbackGenerator(style: .soft)
        let medium = UIImpactFeedbackGenerator(style: .medium)
        let rigid = UIImpactFeedbackGenerator(style: .rigid)

        switch style {
        case .light:
            soft.impactOccurred()
        case .medium:
            medium.impactOccurred()
        case .heavy:
            heavy.impactOccurred()
        case .rigid:
            rigid.impactOccurred()
        }
       
        
    }
    
    
}
