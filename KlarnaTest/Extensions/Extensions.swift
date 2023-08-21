//
//  Extensions.swift
//  KlarnaTest
//
//  Created by Taranjeet Kaur on 26/07/23.
//

import Foundation

extension Double {
    func roundDouble() -> String {
        return String(format: "%.0f", self)
    }
}

extension DateFormatter {
    static let timeOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h a"
        return formatter
    }()

    static let dateOnly: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "YYYY-MM-dd"
         return formatter
    }()
    
    static let dayOnly: DateFormatter = {
         let formatter = DateFormatter()
         formatter.dateFormat = "EEE"
         return formatter
    }()
}

extension Array {
    func unique<T:Hashable>(by: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>()
        var arrayOrdered = [Element]()
        for value in self {
            if !set.contains(by(value)) {
                set.insert(by(value))
                arrayOrdered.append(value)
            }
        }
        return arrayOrdered
    }
}
