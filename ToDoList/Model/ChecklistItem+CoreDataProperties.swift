//
//  ChecklistItem+CoreDataProperties.swift
//  ToDoList
//
//  Created by Niall Mullally on 14/12/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//
//

import Foundation
import CoreData


extension ChecklistItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ChecklistItem> {
        return NSFetchRequest<ChecklistItem>(entityName: "ChecklistItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var checked: Bool

}
