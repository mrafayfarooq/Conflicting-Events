//
//  Formatter.swift
//  ConflictingEvents
//
//  Created by Rafay, Muhammad on 12/13/21.
//

import Foundation
struct Formatter {
    static let simpleDateFormatter: DateFormatter = {
      var dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMMM d, yyyy h:mm a"
      return dateFormatter
    }()
    static let groupDateFormatter: DateFormatter = {
      var dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "MMMM d, yyyy"
      return dateFormatter
    }()
    static let simpleTimeFormatter: DateFormatter = {
      var dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "h:mm a"
      return dateFormatter
    }()
}
