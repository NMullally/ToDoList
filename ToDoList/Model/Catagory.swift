//
//  Catagory.swift
//  ToDoList
//
//  Created by Niall Mullally on 07/01/2019.
//  Copyright © 2019 Niall Mullally. All rights reserved.
//

import Foundation
import RealmSwift

class Catagory : Object
{
    @objc dynamic var name : String = ""
    
    // relationship between item and catagory
    // each catagory has a list of items
    let items = List<Item>()
}

