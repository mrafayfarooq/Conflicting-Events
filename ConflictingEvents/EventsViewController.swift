//
//  EventsViewController.swift
//  ConflictingEvents
//
//  Created by Rafay, Muhammad on 12/13/21.
//

import Foundation
import UIKit
class EventsViewController: UITableViewController {
    var binaryTree: Tree?
    var groupedEvents: [Section]? {
        didSet {
            if isViewLoaded {
                self.tableView.reloadData()
            }
        }
    }
    override func viewDidLoad() {
        WebServices.loadData { (events, error) in
            if error == nil, let events = events {
                self.binaryTree = Tree()
                let sortedEvents = events.sorted()
                for event in sortedEvents {
                    self.binaryTree?.createNodeAtRoot(event: event)
                }
                DispatchQueue.main.async {
                    self.groupedEvents = self.getSectionsByDate(from: sortedEvents)
                }
            }
        }
    }
    // MARK: - Table View Data Source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let eventCell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath) as? EventCell {
            if let event = groupedEvents?[indexPath.section].events[indexPath.row] {
                eventCell.title.text = event.title
                eventCell.startDate.text = event.startTime
                eventCell.endDate.text = event.endTime
                checkForConflicts(cell: eventCell, in: event)
                return eventCell
            }

        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupedEvents?[section].events.count ?? 0
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return groupedEvents?.count ?? 0
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return groupedEvents?[section].dateString ?? ""
    }
    
    
    //MARK: - Private functions
    private func getSectionsByDate(from events: [Events]) -> [Section] {
        let grouped = Dictionary(grouping: events) { $0.startGroupDateString }
        let sections = grouped.map { Section(dateString: $0.key ?? "", events: $0.value) }
        return sections.sorted(by: <)
    }
    
    private func checkForConflicts(cell: UITableViewCell, in event: Events) {
        let collisionFlag = self.binaryTree?.foundCollisionFromEvent(event: event)
        switch (collisionFlag) {
            case .undefined:
                cell.backgroundColor = .clear
            case .clear:
                cell.backgroundColor = .clear
            case .hit:
                cell.backgroundColor = .red
            default:
                cell.backgroundColor = .clear
                
        }
    }
}
