//
//  StringExtension.swift
//  Expenses
//
//  Created by Anfernee Viduya on 7/21/22.
//

import Foundation


extension String.StringInterpolation {
    
    mutating func appendInterpolation(if condition: @autoclosure () -> Bool, _ literal: StringLiteralType) {
        guard condition() else { return }
        appendLiteral(literal)
    }
    
}
