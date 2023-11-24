//
//  LockGifType.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//

import SwiftUI


enum FamilyGifLock: Int, CaseIterable {
    
    case rectangle = 1
    case square = 2
    
    var name: String {
        switch self {
        case .square:
            return "square"
        case .rectangle:
            return "rectangle"
        }
    }
    
    static func getType(name: String) -> FamilyGifLock {
        
        for type in FamilyGifLock.allCases {
            if type.name == name {
                return type
            }
        }
        
        return .square
        
    }
}
