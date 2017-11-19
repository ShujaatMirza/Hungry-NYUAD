//
//  OrderGroup.swift
//  Hungry-NYUAD
//
//  Created by Andrew Callender on 11/19/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class OrderGroup {
    
    init?(id:String, name:String, restaurant:String) {
        self.id = id
        self.name = name
        self.restaurant = restaurant
    }
    
    //MARK: Properties
    var id: String
    var name: String
    var restaurant: String
    
}


