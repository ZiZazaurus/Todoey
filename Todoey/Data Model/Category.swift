//
//  Category.swift
//  Todoey
//
//  Created by Miles, Zipporah on 11/26/18.
//  Copyright © 2018 Miles, Zipporah. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
