//
//  LockGifType.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI


enum FamilyLock: Int, CaseIterable {
    
    case rectangle = 1
    case square = 2
    case inline = 3
    
    var name: String {
        switch self {
        case .square:
            return "square"
        case .rectangle:
            return "rectangle"
        case .inline:
            return "inline"
        }
    }
    
    static func getType(name: String) -> FamilyLock {
        
        for type in FamilyLock.allCases {
            if type.name == name {
                return type
            }
        }
        
        return .square
        
    }
}
