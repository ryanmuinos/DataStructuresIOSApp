//
//  Node.swift
//  Data Structures
//
//  Created by Ryan muinos on 9/19/20.
//

import SwiftUI

class Node {
    var val: Int
    var left: Node?
    var right: Node?
    
    
    init(val: Int, left: Node? = nil, right: Node? = nil) {
        self.val = val
        self.left = left
        self.right = right
    }
    
    
}
