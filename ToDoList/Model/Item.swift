//
//  Item.swift
//  ToDoList
//
//  Created by Niall Mullally on 07/01/2019.
//  Copyright © 2019 Niall Mullally. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object
{
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var date : Date = Date()
    
    // each item has a catagory
    var parentCatagory = LinkingObjects(fromType: Catagory.self, property: "items")
}
