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
}
