//
//  Category.swift
//  TestMenu
//
//  Created by Andrey Apet on 10.02.17.
//  Copyright © 2017 i.Apet. All rights reserved.
//

import Foundation

class Category: NSObject {
    var name: String
    var id: String
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
    }
}
