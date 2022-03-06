//
//  EventCell.swift
//  ConflictingEvents
//
//  Created by Rafay, Muhammad on 12/14/21.
//

import Foundation
import UIKit
class EventCell: UITableViewCell {
    static let identifier = "EventCell"
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var title: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.startDate.text = nil
        self.endDate.text = nil
        self.title.text = nil
    }
}
