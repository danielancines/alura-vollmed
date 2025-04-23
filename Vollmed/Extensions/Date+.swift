//
//  Date+.swift
//  Vollmed
//
//  Created by daniel.ancines on 23/04/25.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Formats.backendDateFormat
        
        return dateFormatter.string(from: self)
    }
}
