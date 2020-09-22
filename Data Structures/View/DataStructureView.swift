//
//  DataStructure.swift
//  Data Structures
//
//  Created by Ryan muinos on 9/19/20.
//

//BSTView, Line, and Circle modified from Chris Eidhof and
//his "Drawing Binary Trees" Article


import SwiftUI


struct DataStructureView: View {
    var DS: DataStructure
    
    var body: some View {
        ZStack {
            
            
            
            VStack {
                VisualEffectBlur(blurStyle: .systemUltraThinMaterial, vibrancyStyle: .none) {
                    VStack {
                        
                        //Text(DS.name)
                        //  .font(.largeTitle).padding(.top, 10.0)
                        Text(String(DS.name))
                            .font(.largeTitle).padding(.top, 20.0)
                        Spacer()
                        if DS is BST {
                            BSTView(tree: (DS as! BST).returnTreeChildren(root: (DS as! BST).root!), node: (DS as! BST).root!, first: true)
                        } else if DS is LinkedList {
                            LinkedListView(list: (DS as! LinkedList).returnListChildren(root: (DS as! LinkedList).head!), node: (DS as! LinkedList).head!, first: true)
                        }
                        Spacer()
                        
                    }
                }.background(LinearGradient(
                    gradient: Gradient(colors: [.purple, .blue, .green]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                
                
                
            }
        }
    }
}

struct NodeView: View {
    var first: Bool
    var node: Node
    var body: some View {
        if (node.val > 0) {
            
            Text(String(node.val)).modifier(RoundedCircleStyle(root: first))
            
        } else {
            Circle().frame(width: 25, height: 25, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/).opacity(0.0)
        }
        
    }
    
}

struct CollectDict<Key: Hashable, Value>: PreferenceKey {
    static var defaultValue: [Key:Value] { [:] }
    static func reduce(value: inout [Key:Value], nextValue: () -> [Key:Value]) {
        value.merge(nextValue(), uniquingKeysWith: { $1 })
    }
}


struct RoundedCircleStyle: ViewModifier {
    let root: Bool
    func body(content: Content) -> some View {
        if (root) {
            return content
                .frame(width: 50, height: 50)
                .background(Circle().stroke(Color.black))
                .background(Circle().fill(Color(UIColor.yellow)))
                .padding(10)
        } else {
            return content
                .frame(width: 50, height: 50)
                .background(Circle().stroke(Color.black))
                .background(Circle().fill(Color.white))
                .padding(10)
        }
        
    }
}

struct Line: Shape {
    var from: CGPoint
    var to: CGPoint
    var animatableData: AnimatablePair<CGPoint, CGPoint> {
        get { AnimatablePair(from, to) }
        set {
            from = newValue.first
            to = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        Path { p in
            p.move(to: self.from)
            p.addLine(to: self.to)
        }
    }
}

extension CGPoint: VectorArithmetic {
    public static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs - rhs
    }
    
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    public static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
    
    public mutating func scale(by rhs: Double) {
        x *= CGFloat(rhs)
        y *= CGFloat(rhs)
    }
    
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    public var magnitudeSquared: Double { return Double(x*x + y*y) }
}



struct DataStructureView_Previews: PreviewProvider {
    static var previews: some View {
        let BST1: BST = BST()
        BST1.insert(value: 3)
        BST1.insert(value: 5)
        BST1.insert(value: 2)
        BST1.insert(value: 1)
        BST1.insert(value: 3)
        BST1.insert(value: 4)
        BST1.insert(value: 7)
        BST1.insert(value: 8)
        
        return DataStructureView(DS: BST1)
        
        
    }
}
