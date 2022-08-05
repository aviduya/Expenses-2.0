//
//  HomeModel.swift
//  Expenses
//
//  Created by Anfernee Viduya on 7/9/22.
//

import Foundation

enum ActiveView: Identifiable {
    
    case settings
    case add
    case all
    
    var id: Int {
        hashValue
    }
}
