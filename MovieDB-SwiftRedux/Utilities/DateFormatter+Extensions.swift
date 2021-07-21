//
//  DateFormatter+Extensions.swift
//  DateFormatter+Extensions
//
//  Created by Lucas Lima on 21.07.21.
//

import Foundation

extension DateFormatter {
    static let mediumDate: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter
    }()
}
