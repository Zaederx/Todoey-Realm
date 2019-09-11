//
//  Item.swift
//  Todoey-Realm
//
//  Created by Zachary Ishmael on 10/09/2019.
//  Copyright © 2019 Zachary Ishmael. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var checked: Bool = false
    var parentCategory = LinkingObjects(fromType:Todo.self, property:"items")
}
