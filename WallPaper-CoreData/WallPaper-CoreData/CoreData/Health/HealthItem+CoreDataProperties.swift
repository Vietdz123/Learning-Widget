//
//  HealthItem+CoreDataProperties.swift
//  WallPaper-CoreData
//
//  Created by MAC on 29/11/2023.
//
//

import Foundation
import CoreData


extension HealthItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HealthItem> {
        return NSFetchRequest<HealthItem>(entityName: "HealthItem")
    }

    @NSManaged public var name: String?

}
