//
//  CategoryLockExtension.swift
//  WallPaper-CoreData
//
//  Created by MAC on 24/11/2023.
//


import SwiftUI

extension CategoryLock {
    
    public var unwrappedName: String {
        name ?? "Unknown name"
    }
    
    public var unwrappedLockType: String {
        lockType ?? "Unknown name"
    }
    
    public var unwrappedFamily: String {
        familyType ?? "Unknown name"
    }
    
    public var unwrappedTextAlignment: String {
        textAlignment ?? "Unknown name"
    }
    
    public var unwrappedTextColor: String {
        textColor ?? "Unknown name"
    }
    
    public var unwrappedSoundType: String {
        soundType ?? "Unknown name"
    }
    
    public var unwrappedFontType: String {
        fontType ?? "Unknown name"
    }
    
    public var itemArray: [Item] {
        
        let itemSet = items as? Set<Item> ?? []
        
        return itemSet.sorted {
            $0.creationDate < $1.creationDate
        }
    }
    
    func getItemFamily(filter: FamilyHome) -> [Item] {
        
        let itemSet = items as? Set<Item> ?? []
        
        let familyItem = itemSet.filter { item in
            return item.unwrappedFamily.contains(filter.rawValue)
        }
        
        return familyItem.sorted {
            $0.creationDate < $1.creationDate
        }
    }
    

}
