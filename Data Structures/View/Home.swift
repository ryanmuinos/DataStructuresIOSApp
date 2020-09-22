//
//  Home.swift
//  Data Structures
//
//  Created by Ryan muinos on 9/19/20.
//


//Carousel Home Page modified from
//https://gist.github.com/xtabbas/97b44b854e1315384b7d1d5ccce20623

import SwiftUI

struct Home: View {
    @ObservedObject var viewModel: DataStructureManagerMV
    @EnvironmentObject var UIState: UIStateModel
    var body: some View {
        let spacing: CGFloat = 20
        let widthOfHiddenCards: CGFloat = 32 // UIScreen.main.bounds.width - 10
        let cardHeight: CGFloat = 650
        
        let DStructures = viewModel.DSArr
        VStack {
            ZStack {
                HStack {
                    Button(action: {}) {
                        Image(systemName: "line.horizontal.3")
                            .padding()
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.black)
                        
                    }
                    
                    Spacer(minLength: 0)
                    
                }
                
                
                Text("Data Structures").bold()
                
            }.background(Color.black.opacity(0.05).ignoresSafeArea(.all))
            
            Canvas {
                
                Carousel(
                    numberOfItems: CGFloat(DStructures.count),
                    spacing: spacing,
                    widthOfHiddenCards: widthOfHiddenCards
                ) {
                    ForEach(DStructures, id: \.self.id) { item in
                        Item(
                            _id: Int(item.id),
                            spacing: spacing,
                            widthOfHiddenCards: widthOfHiddenCards,
                            cardHeight: cardHeight
                        ) {
                            DataStructureView(DS: item)
                        }
                        .foregroundColor(Color.black)
                        .background(Color.gray)
                        .cornerRadius(8)
                        .shadow(color: Color.black, radius: 4, x: 0, y: 4)
                        .transition(AnyTransition.slide)
                        .animation(.spring())
                    }
                }
                .environmentObject(self.UIState)
            }
            
            
            
            
            
        }
        
    }
}



struct Carousel<Items : View> : View {
    let items: Items
    let numberOfItems: CGFloat //= 8
    let spacing: CGFloat //= 16
    let widthOfHiddenCards: CGFloat //= 32
    let totalSpacing: CGFloat
    let cardWidth: CGFloat
    
    @GestureState var isDetectingLongPress = false
    
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable public init(
        numberOfItems: CGFloat,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        @ViewBuilder _ items: () -> Items) {
        
        self.items = items()
        self.numberOfItems = numberOfItems
        self.spacing = spacing
        self.widthOfHiddenCards = widthOfHiddenCards
        self.totalSpacing = (numberOfItems - 1) * spacing
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        
    }
    
    var body: some View {
        let totalCanvasWidth: CGFloat = (cardWidth * numberOfItems) + totalSpacing
        let xOffsetToShift = (totalCanvasWidth - UIScreen.main.bounds.width) / 2
        let leftPadding = widthOfHiddenCards + spacing
        let totalMovement = cardWidth + spacing
        
        let activeOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard))
        let nextOffset = xOffsetToShift + (leftPadding) - (totalMovement * CGFloat(UIState.activeCard) + 1)
        
        var calcOffset = Float(activeOffset)
        
        if (calcOffset != Float(nextOffset)) {
            calcOffset = Float(activeOffset) + UIState.screenDrag
        }
        
        return HStack(alignment: .center, spacing: spacing) {
            items
        }
        .offset(x: CGFloat(calcOffset), y: 0)
        .gesture(DragGesture().updating($isDetectingLongPress) { currentState, gestureState, transaction in
            self.UIState.screenDrag = Float(currentState.translation.width)
            
        }.onEnded { value in
            self.UIState.screenDrag = 0
            
            if (value.translation.width < -50 && CGFloat(self.UIState.activeCard) < numberOfItems - 1) {
                self.UIState.activeCard = self.UIState.activeCard + 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
            
            if (value.translation.width > 50 && CGFloat(self.UIState.activeCard) > 0) {
                self.UIState.activeCard = self.UIState.activeCard - 1
                let impactMed = UIImpactFeedbackGenerator(style: .medium)
                impactMed.impactOccurred()
            }
        })
    }
}

public class UIStateModel: ObservableObject {
    @Published var activeCard: Int = 0
    @Published var screenDrag: Float = 0.0
}


struct Canvas<Content : View> : View {
    let content: Content
    @EnvironmentObject var UIState: UIStateModel
    
    @inlinable init(@ViewBuilder _ content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(Color.white.edgesIgnoringSafeArea(.all))
    }
}

struct Item<Content: View>: View {
    @EnvironmentObject var UIState: UIStateModel
    let cardWidth: CGFloat
    let cardHeight: CGFloat
    
    var _id: Int
    var content: Content
    
    @inlinable public init(
        _id: Int,
        spacing: CGFloat,
        widthOfHiddenCards: CGFloat,
        cardHeight: CGFloat,
        @ViewBuilder _ content: () -> Content
    ) {
        self.content = content()
        self.cardWidth = UIScreen.main.bounds.width - (widthOfHiddenCards*2) - (spacing*2) //279
        self.cardHeight = cardHeight
        self._id = _id
    }
    
    var body: some View {
        content
            .frame(width: cardWidth, height: _id == UIState.activeCard ? cardHeight : cardHeight - 60, alignment: .center)
    }
}

struct Home_Previews: PreviewProvider {
    @EnvironmentObject var UIState: UIStateModel
    
    static var previews: some View {
        
        let modelView = DataStructureManagerMV()
        let BST1: BST = BST()
        BST1.insert(value: 3)
        BST1.insert(value: 5)
        BST1.insert(value: 2)
        BST1.insert(value: 1)
        BST1.insert(value: 10)
        BST1.insert(value: 4)
        BST1.insert(value: 7)
        BST1.insert(value: 8)
        modelView.insert(DS: BST1)
        let BST2: BST = BST()
        BST2.insert(value: 3)
        BST2.insert(value: 1)
        BST2.insert(value: 2)
        
        BST2.insert(value: 10)
        BST2.insert(value: 7)
        BST2.insert(value: 8)
        modelView.insert(DS: BST2)
        
        
        let BST3: BST = BST()
        BST3.insert(value: 3)
        BST3.insert(value: 1)
        BST3.insert(value: 2)
        
        modelView.insert(DS: BST3)
        
        
        
        let BST4: BST = BST()
        BST4.insert(value: 3)
        BST4.insert(value: 1)
        BST4.insert(value: 2)
        BST4.insert(value: 10)
        BST4.insert(value: 7)
        BST4.insert(value: 8)
        modelView.insert(DS: BST4)
        
        
        let BST5: BST = BST()
        BST5.insert(value: 3)
        BST5.insert(value: 1)
        
        BST5.insert(value: 7)
        BST5.insert(value: 8)
        modelView.insert(DS: BST5)
        
        return Home(viewModel: modelView).environmentObject(UIStateModel())
    }
}

