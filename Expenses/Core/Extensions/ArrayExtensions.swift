//
//  ArrayExtensions.swift
//  Expenses
//
//  Created by Anfernee Viduya on 4/27/22.
//

import Foundation


extension Array where Element: Equatable {

    func filtered() -> [Element] {
        let countedSet = NSCountedSet(array: self)
        let mostPopularElement = self.max { countedSet.count(for: $0) < countedSet.count(for: $1) }
        return self.filter { $0 == mostPopularElement }
    }

}
