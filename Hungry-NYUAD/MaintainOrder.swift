//
//  MaintainOrder.swift
//  Hungry-NYUAD
//
//  This protocol allows the parent tableview controller to keep
//  track of the user's interactions with cell views so orders can
//  be collected.
//
//  Created by Mawutor Ama Abalo on 12/5/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import Foundation
protocol MaintainOrder {
    func addItem(menuItem: MenuItem);
    func removeItem(menuItem: MenuItem);
}
