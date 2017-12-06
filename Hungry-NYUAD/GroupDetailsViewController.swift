//
//  GroupDetailsViewController.swift
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
    @IBOutlet weak var orderGroupCapacity: UILabel!
    @IBOutlet weak var orderGroupNumber: UILabel!
    
//    @IBAction func joinOrderGroup(_ sender: Any) {
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orderGroupId.text = orderGroupObject?.id
        self.orderGroupName.text = orderGroupObject?.name
        self.orderGroupRestaurant.text = orderGroupObject?.restaurant
        self.orderGroupNumber.text = String(describing: orderGroupObject!.numMembers)
        self.orderGroupCapacity.text = "You cannot join this group"
        
        if (orderGroupObject?.hasReachedCapacity == false) {
            self.orderGroupCapacity.text = "You can join this group"
        }
    }
    
    func joinGroup() {
        var currentUserId : String = (Auth.auth().currentUser?.uid)!
        
        
    }
    
}
