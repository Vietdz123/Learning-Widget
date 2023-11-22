//
//  Item+CoreDataProperties.swift
//  
//
//  Created by MAC on 22/11/2023.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var creationDate: Double
    @NSManaged public var family: String?
    @NSManaged public var name: String?
    @NSManaged public var routine_type: String?

}
