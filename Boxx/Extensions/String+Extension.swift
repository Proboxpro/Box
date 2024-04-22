//
//  String+Extension.swift
//  Boxx
//
//  Created by Nikita Evdokimov on 12.04.24.
//

import Foundation

extension String {
    func toDate() -> Date? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "dd.MM.yyyy в HH:mm"
        
        return inputDateFormatter.date(from: self)
    }
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String {
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertToMonthYearFormat()
    }
}
