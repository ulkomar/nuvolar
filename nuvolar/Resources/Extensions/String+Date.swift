//
//  String+Date.swift
//  nuvolar
//
//  Created by Developer on 9.06.24.
//

import Foundation

extension String {
    func toReadableDateFormatt() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        let stringDateFormatter = DateFormatter()

        // Set Date Format
        stringDateFormatter.dateFormat = "d MMM, YYYY"

        // Convert Date to String
        return stringDateFormatter.string(from: date)
    }
}

