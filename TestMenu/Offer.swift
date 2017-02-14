//
//  Offer.swift
//  TestMenu
//
//  Created by Andrey Apet on 11.02.17.
//  Copyright © 2017 i.Apet. All rights reserved.
//

import Foundation

class Offer: NSObject {
    
    var name: String
    var price: String
    var descr: String
    var picture: String
    var id: String
    var weight: String
    
    init(name: String, price: String, descr: String, picture: String, id: String, weight: String) {
        self.name = name
        self.price = price
        self.descr = descr
        self.picture = picture
        self.id = id
        self.weight = weight
    }
    
}
