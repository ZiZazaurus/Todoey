//
//  Item.swift
//  Todoey
//
//  Created by Miles, Zipporah on 11/26/18.
//  Copyright © 2018 Miles, Zipporah. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    
    @objc dynamic var title : String = ""
    @objc dynamic var done : Bool = false
    
    @objc dynamic var dateCreated : Date?
    
    var parent = LinkingObjects(fromType: Category.self, property: "items")
}
