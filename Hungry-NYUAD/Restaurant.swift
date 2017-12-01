//
//  Restaurant.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 11/24/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import Foundation

class Restaurant {
    var name: String
    var hours: String
    var phone: String
    var website: String
    var menuId: String
    
    init(name: String, hours: String, phone: String, website: String, menuId: String) {
        self.name = name
        self.hours = hours
        self.phone = phone
        self.website = website
        self.menuId = menuId
    }
    
}
