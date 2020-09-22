//
//  DataStructureManager.swift
//  Data Structures
//
//  Created by Ryan muinos on 9/19/20.
//

import Foundation

struct DataStructureManager {
    var DataStructures: Array<DataStructure>
    
    var count: Int = 0
    
    mutating func insertDataStructure(ds: DataStructure) {
        ds.id = count
        count += 1
        DataStructures.append(ds)
    }
    
    
    init (Arr: Array<DataStructure>) {
        for ds in Arr {
            ds.id = count
            count += 1
        }
        DataStructures = Arr
    }
    
}

enum DSMethods {
    case insert
}
