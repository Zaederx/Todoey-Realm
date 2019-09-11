//
//  Todo.swift
//  Todoey-Realm
//
//  Created by Zachary Ishmael on 10/09/2019.
//  Copyright © 2019 Zachary Ishmael. All rights reserved.
//

import Foundation
import RealmSwift

class Todo: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
