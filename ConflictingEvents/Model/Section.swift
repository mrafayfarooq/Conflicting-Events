//
//  Section.swift
//  ConflictingEvents
//
//  Created by Rafay, Muhammad on 12/14/21.
//

import Foundation
struct Section: Comparable {
    var dateString: String
    var events: [Events]
    
    static func < (lhs: Section, rhs: Section) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d, yyyy"
        if let lhsDate = dateFormatter.date(from: lhs.dateString), let rhsDate = dateFormatter.date(from: rhs.dateString) {
            return  lhsDate < rhsDate
        }
        return false
    }
    
}
