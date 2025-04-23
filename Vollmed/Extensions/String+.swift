//
//  String+.swift
//  Vollmed
//
//  Created by daniel.ancines on 23/04/25.
//

import Foundation

extension String {
    func dateToString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Formats.backendDateFormat
            
        if let date = dateFormatter.date(from: self){
            dateFormatter.dateFormat = format
            return dateFormatter.string(from: date)
        }
        return ""
    }
}
