//
//  CategoryLock+CoreDataProperties.swift
//  WallPaper-CoreData
//
//  Created by Three Bros on 25/11/2023.
//
//

import Foundation
import CoreData


extension CategoryLock {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryLock> {
        return NSFetchRequest<CategoryLock>(entityName: "CategoryLock")
    }

    @NSManaged public var creationDate: Double
    @NSManaged public var delayAnimation: Double
    @NSManaged public var familyType: String?
    @NSManaged public var fontSize: Double
    @NSManaged public var fontType: String?
    @NSManaged public var hasSound: Bool
    @NSManaged public var isFirstImage: Bool
    @NSManaged public var lockType: String?
    @NSManaged public var name: String?
    @NSManaged public var numberImagesRect: Double
    @NSManaged public var numberImagesSquare: Double
    @NSManaged public var soundType: String?
    @NSManaged public var textAlignment: String?
    @NSManaged public var textColor: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension CategoryLock {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: Item)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: Item)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
