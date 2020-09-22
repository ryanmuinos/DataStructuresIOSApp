//
//  BST.swift
//  Data Structures
//
//  Created by Ryan muinos on 9/19/20.
//

import SwiftUI



class BST: DataStructure {

    var root: Node?
    
    var height: Int
    override var name: String {
        get {
            return "Binary Search Tree"
            
        }
        set {}
    }
    
    
    override func insert(value: Int) {
        let insertNode = Node(val: value)
        if let root = self.root {
            insertRec(root: root, insertNode: insertNode, h: 1)
            
        } else {
            root = insertNode
            height = 1
        }
    }
    override init() {
        root = nil
        height = 0
        
    }
    
    private func insertRec(root: Node, insertNode: Node, h: Int) {
        height = (h > height) ? h : height
        if (root.val < insertNode.val) {
            if let right = root.right {
                insertRec(root: right, insertNode: insertNode, h: h+1)
            } else {
                root.right = insertNode
            }
        } else {
            if let left = root.left {
                insertRec(root: left, insertNode: insertNode, h: h+1)
            } else {
                root.left = insertNode
            }
        }
        
    }
    
    func levelOrder(root: Node) -> [[Node]] {
        var arr = [[Node]]()
        
        dfs(returnList: &arr, node: root, level: 0)
        
        return arr
        
    }
    
    private func dfs( returnList: inout [[Node]], node: Node?, level: Int) {
        
        if (level <= height) {
            
            if (returnList.count <= level) {
                returnList.append([])
            }
            returnList[level].append(node ?? Node(val: 0))
            
            
            dfs(returnList: &returnList, node: node?.left, level: level+1)
            dfs(returnList: &returnList, node: node?.right, level: level+1)
            
            
        }
    }
    
    func inOrder(root: Node) {
        
    }
    
    func returnTreeChildren(root: Node) -> TreeChildren {
        TreeChildren(node: root)
    }
    
}

struct TreeChildren {
    var node: Node?
    var val: Int
    var children: [TreeChildren] = []
    init(node: Node?, children: [TreeChildren] = []) {
        self.node = node
        self.val = node?.val ?? 0
        if (node?.left != nil)  { self.children.append(TreeChildren(node: node?.left)) }
        if (node?.right != nil) { self.children.append(TreeChildren(node: node?.right)) }
    }
}



