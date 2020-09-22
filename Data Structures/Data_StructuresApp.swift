//
//  Data_StructuresApp.swift
//  Data Structures
//
//  Created by Ryan muinos on 9/19/20.
//

import SwiftUI

@main
struct Data_StructuresApp: App {
    var body: some Scene {
        WindowGroup { () -> Home in
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
            return Home(viewModel: modelView).environmentObject(UIStateModel()) as! Home
            
        }
    }
}

struct Data_StructuresApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
