//
//  Catagory+CoreDataProperties.swift
//  ToDoList
//
//  Created by Niall Mullally on 19/12/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//
//

import Foundation
import CoreData


extension Catagory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Catagory> {
        return NSFetchRequest<Catagory>(entityName: "Catagory")
    }

    @NSManaged public var name: String?
    @NSManaged public var items: NSSet?

}

// MARK: Generated accessors for items
extension Catagory {

    @objc(addItemsObject:)
    @NSManaged public func addToItems(_ value: ChecklistItem)

    @objc(removeItemsObject:)
    @NSManaged public func removeFromItems(_ value: ChecklistItem)

    @objc(addItems:)
    @NSManaged public func addToItems(_ values: NSSet)

    @objc(removeItems:)
    @NSManaged public func removeFromItems(_ values: NSSet)

}
