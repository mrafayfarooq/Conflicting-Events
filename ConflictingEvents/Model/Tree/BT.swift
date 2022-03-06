//
//  Node.swift
//  ConflictingEvents
//
//  Created by Rafay, Muhammad on 12/15/21.
//

import Foundation
import UIKit

public class Node {
    var max: Date
    var left: Node?
    var right: Node?
    var event: Events
    init(event: Events) {
        self.event = event
        self.max = event.end
    }
    init(node: Node) {
        self.event = node.event
        self.max = node.max
    }
}

public class Tree {
    var root: Node? = nil

    func createNodeAtRoot(event: Events) {
        self.root = inserNode(root, with: event)
    }
    func inserNode(_ node: Node?, with event: Events) -> Node {
        guard let node = node else {
            return Node(event: event)
        } 
        if event.start < node.event.start {
            node.left = inserNode(node.left, with: event)
        } else {
            node.right = inserNode(node.right, with: event)
        }
        if node.max < event.end {
            node.max = event.end
        }
        return node
    }
    func foundCollisionFromNode(root: Node?, event: Events) -> Events? {
        guard let root = root else {
            return nil
        }
        if event.isInConflictWith(event: root.event) {
            return root.event
        }
        if let leftNode = root.left, leftNode.max >= event.start {
            return foundCollisionFromNode(root: root.left, event: event)
        }
        return foundCollisionFromNode(root: root.right, event: event)
    }
    func foundCollisionFromEvent(event: Events) -> CollisionFlag? {
        if event.collisionFlag != nil {
            return event.collisionFlag
        }
        if foundCollisionFromNode(root: root, event: event) != nil {
            return .hit
        }
        return .clear
    }

}
