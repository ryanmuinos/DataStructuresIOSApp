//
//  BSTView.swift
//  Data Structures
//
//  Created by Ryan muinos on 9/20/20.
//

//BSTView, Line, and Circle modified from Chris Eidhof and
//his "Drawing Binary Trees" Article

import SwiftUI



struct LinkedListView: View {
    let list: ListChildren
    let node: Node
    let first: Bool 
    typealias Key = CollectDict<Int, Anchor<CGPoint>>
    
    var body: some View {
        VStack(alignment: .center) {
            NodeView(first: first, node: node)
                .anchorPreference(key: Key.self, value: .center, transform: {
                    [self.list.val: $0]
                })
            
            VStack(spacing: 10) {
                ForEach(list.children, id: \.val, content: { child in
                    LinkedListView(list: child, node: child.node!, first: false)
                })
            }
        }.backgroundPreferenceValue(Key.self, { (centers: [Int: Anchor<CGPoint>]) in
            GeometryReader { proxy in
                ForEach(self.list.children, id: \.val, content: {
                    child in
                    Line(
                        from: proxy[centers[self.list.val]!],
                        to: proxy[centers[child.val]!])
                        .stroke()
                })
            }
        })
    }
}


struct LinkedListView_Previews: PreviewProvider {
    static var previews: some View {
        let LL1: LinkedList = LinkedList()
        LL1.insert(value: 3)
        LL1.insert(value: 5)
        LL1.insert(value: 2)
        LL1.insert(value: 1)
        LL1.insert(value: 10)
        LL1.insert(value: 4)
        LL1.insert(value: 7)
        LL1.insert(value: 8)
        
        return LinkedListView(list: LL1.returnListChildren(root: LL1.head!), node: LL1.head!, first: true)
    }
}



