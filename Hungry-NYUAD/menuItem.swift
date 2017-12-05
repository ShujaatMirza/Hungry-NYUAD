//
//  MenuItem.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/1/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import Foundation
class MenuItem: Hashable{
    
    var id: String
    var name: String
    var price: Double
    
    var hashValue: Int {
        return id.hashValue
    }
    
    static func ==(lhs: MenuItem, rhs: MenuItem) -> Bool {
            return lhs.id == rhs.id
    }
    
    init(name: String, price: Double, id: String) {
        self.id = id
        self.name = name
        self.price = price
    }
}
