//
//  ChecklistItem.swift
//  ToDoList
//
//  Created by Niall Mullally on 13/12/2018.
//  Copyright © 2018 Niall Mullally. All rights reserved.
//

import Foundation

class ChecklistItem : Encodable, Decodable
{
    var title: String = ""
    var checked: Bool = false
    
    init(_ name : String)
    {
        title = name
    }
}
