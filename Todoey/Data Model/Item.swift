//
//  ToDoStatus.swift
//  Todoey
//
//  Created by Miles, Zipporah on 11/19/18.
//  Copyright © 2018 Miles, Zipporah. All rights reserved.
//

import Foundation

class Item: Encodable, Decodable  {
    var title : String = ""
    var done : Bool = false
}
