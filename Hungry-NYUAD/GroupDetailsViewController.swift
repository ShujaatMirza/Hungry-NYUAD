//
//  OrderManViewController.swift
//  Hungry-NYUAD
//
//  Created by Andrew Callender on 11/16/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import Foundation
import Firebase

class GroupDetailsViewController : UIViewController {
    var orderGroupObject : OrderGroup? = nil
    
    @IBOutlet weak var orderGroupRestaurant: UILabel!
    @IBOutlet weak var orderGroupName: UILabel!
    @IBOutlet weak var orderGroupId: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderGroupId.text = orderGroupObject?.id
        self.orderGroupName.text = orderGroupObject?.name
        self.orderGroupRestaurant.text = orderGroupObject?.restaurant
        
    }
    


        
}
