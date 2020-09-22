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
        WindowGroup {
            Home(viewModel: DataStructureManagerMV()).environmentObject(UIStateModel())
            
        }
    }
}

struct Data_StructuresApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
