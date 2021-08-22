//
//  DateFormatter+Extensions.swift
//  DateFormatter+Extensions
//
//  Created by Lucas Lima on 21.07.21.
//

import Foundation

extension DateFormatter {
    static let longDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    static let mediumDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
    
    static let year: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.setLocalizedDateFormatFromTemplate("yyyy")
        return dateFormatter
    }()
}
