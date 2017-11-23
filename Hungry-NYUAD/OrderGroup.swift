//
//  OrderGroup.swift
//  Hungry-NYUAD
//
//  Created by Andrew Callender on 11/19/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class OrderGroup {
    
    init?(id:String, name:String, restaurant:String, ownerId:String, IsPlaced: Bool, IsDelivered: Bool, IsCompleted: Bool, hasReachedCapacity: Bool, numMembers: Int) {
        self.id = id
        self.name = name
        self.restaurant = restaurant
        self.ownerId = ownerId
        self.IsPlaced = IsPlaced
        self.IsDelivered = IsDelivered
        self.IsCompleted = IsCompleted
        self.hasReachedCapacity = hasReachedCapacity
        self.numMembers = numMembers
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
}


