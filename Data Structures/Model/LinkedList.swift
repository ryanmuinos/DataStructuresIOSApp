//
//  LinkedList.swift
//  Data Structures
//
//  Created by Ryan muinos on 9/22/20.
//

import SwiftUI

//Class for Doubly Linked List
class LinkedList: DataStructure {
    //Left will serve as prev
    //Right will serve as next
    var head: Node?
    
    
    override var name: String {
        get {
            return "Linked List"
            
        }
        set {}
    }
    
    
    func insertFront(value: Int) {
        let insNode = Node(val: value)
        insNode.right = head
        
        if let h = head {
            h.left = insNode
        }
        
        head = insNode
    }
    
    override func insert(value: Int) {
        let insNode = Node(val: value)
        
        var last = head
        
        insNode.right = nil
        
        if (head == nil) {
            insNode.left = nil
            head = insNode
            return
        }
        
        while (last?.right != nil) {
            last = last?.right
        }
        
        last?.right = insNode
        insNode.left = last
    }
    
    
    override init() {
        head = nil
        
        
    }
    
    func returnListChildren(root: Node) -> ListChildren {
        ListChildren(node: head)
    }
    
    
}
struct ListChildren {
    var node: Node?
    var val: Int
    var children: [ListChildren] = []
    init(node: Node?, children: [ListChildren] = []) {
        self.node = node
        self.val = node?.val ?? 0
        if (node?.right != nil) { self.children.append(ListChildren(node: node?.right)) }
    }
}
