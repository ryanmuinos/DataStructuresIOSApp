//
//  DataStructureMV.swift
//  Data Structures
//
//  Created by Ryan muinos on 9/19/20.
//

import SwiftUI

class DataStructureManagerMV: ObservableObject {
    @Published private(set) var model: DataStructureManager = DataStructureManagerMV.createDataStructureManager(Arr: [])
    
    private static func createDataStructureManager(Arr: Array<DataStructure>) -> DataStructureManager {
        
        return DataStructureManager(Arr: Arr)
    }
    
    
    
    
    
    // MARK: - Access to the Model
    
    var DSArr: Array<DataStructure> {
        model.DataStructures
    }
    
    // MARK: - Intent(s)
    
    func insert(DS: DataStructure) {
        objectWillChange.send()
        model.insertDataStructure(ds: DS)
    }
}
