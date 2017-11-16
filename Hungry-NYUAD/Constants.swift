//
//  Constants.swift
//  Hungry-NYUAD
//
//  Created by Andrew Callender on 11/16/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import Firebase

struct Constants
{
    struct refs
    {
        static let databaseRoot = Database.database().reference()
        static let databaseOrders = databaseRoot.child("orders")
        static let databaseOrderGroup = databaseRoot.child("order_group")
    }
}
