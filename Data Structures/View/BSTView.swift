//
//  BSTView.swift
//  Data Structures
//
//  Created by Ryan muinos on 9/20/20.
//

//BSTView, Line, and Circle modified from Chris Eidhof and
//his "Drawing Binary Trees" Article

import SwiftUI



struct BSTView: View {
    let tree: TreeChildren
    let node: Node
    let first: Bool 
    
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    
    var body: some View {
        VStack(alignment: .center) {
            NodeView(first: first, node: node)
                .anchorPreference(key: Key.self, value: .center, transform: {
                    [self.tree.val: $0]
                })
            HStack(alignment: .bottom, spacing: 10) {
                ForEach(tree.children, id: \.val, content: { child in
                    BSTView(tree: child, node: child.node!, first: false)
                })
            }
        }.backgroundPreferenceValue(Key.self, { (centers: [Int: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                ForEach(self.tree.children, id: \.val, content: {
                    child in
                    Line(
                        from: proxy[centers[self.tree.val]!],
                        to: proxy[centers[child.val]!])
                        .stroke()
                })
            }
        })
    }
}



struct BSTView_Previews: PreviewProvider {
    static var previews: some View {
        let BST1: BST = BST()
        BST1.insert(value: 3)
        BST1.insert(value: 5)
        BST1.insert(value: 2)
        BST1.insert(value: 1)
        BST1.insert(value: 10)
        BST1.insert(value: 4)
        BST1.insert(value: 7)
        BST1.insert(value: 8)
        
        return BSTView(tree: BST1.returnTreeChildren(root: BST1.root!), node: BST1.root!, first: true)
    }
}



