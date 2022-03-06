//
//  Events.swift
//  ConflictingEvents
//
//  Created by Rafay, Muhammad on 12/13/21.
//

import Foundation
enum CollisionFlag: Int, Codable {
    case undefined
    case clear
    case hit
}
public class Events: Decodable {
    
    var title: String
    var start: Date
    var end: Date
    var isInConflict: Bool?
    var collisionFlag: CollisionFlag?
    var startDateString: String? {
        return Formatter.simpleDateFormatter.string(from: start)
    }
    var endDateString: String? {
        return Formatter.simpleDateFormatter.string(from: end)
    }
    var startGroupDateString: String? {
        return Formatter.groupDateFormatter.string(from: start)
    }
    var startTime: String? {
        return Formatter.simpleTimeFormatter.string(from: start)
    }
    var endTime: String? {
        return Formatter.simpleTimeFormatter.string(from: end)
    }
    //MARK: Initialization
    init(title: String, start: Date, end: Date) {
        self.title = title
        self.start = start
        self.end = end
    }
    
}
extension Events: Comparable {
    public static func < (lhs: Events, rhs: Events) -> Bool {
        return lhs.start < rhs.start
    }
    public static func == (lhs: Events, rhs: Events) -> Bool {
        return lhs.start == rhs.start
    }
    public static func > (lhs: Events, rhs: Events) -> Bool {
        return lhs.start > rhs.start
    }
}

extension Events {
    var interval: DateInterval { .init(start: start, end: end) }
    func intersects(with event: Events) -> Bool { interval.intersects(event.interval) }
    func isInConflictWith(event: Events) -> Bool {
        if (self === event) { return false };
        return (self.start < event.end && event.start < self.end);
    }
}
