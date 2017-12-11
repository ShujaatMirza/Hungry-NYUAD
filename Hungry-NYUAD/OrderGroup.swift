//
//  OrderGroup.swift
//  Hungry-NYUAD
//
//  Created by Andrew Callender on 11/19/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

//This will be expanded as more detail elements need to be added to the database

import UIKit

class OrderGroup {
    
    init?(id:String, name:String, restaurant:String, ownerId:String, IsPlaced: Bool, IsDelivered: Bool, IsCompleted: Bool, hasReachedCapacity: Bool, numMembers: Int, menuId: String, orderDate: String) {
        self.id = id
        self.name = name
        self.restaurant = restaurant
        self.ownerId = ownerId
        self.IsPlaced = IsPlaced
        self.IsDelivered = IsDelivered
        self.IsCompleted = IsCompleted
        self.hasReachedCapacity = hasReachedCapacity
        self.numMembers = numMembers
        self.menuId = menuId
        self.orderDate = orderDate
    }
    
    //MARK: Properties
    var id: String
    var name: String
    var restaurant: String
    var ownerId: String
    var IsPlaced: Bool
    var IsDelivered: Bool
    var IsCompleted: Bool
    var hasReachedCapacity: Bool
    var numMembers: Int
    var menuId: String
    var orderDate: String
}


