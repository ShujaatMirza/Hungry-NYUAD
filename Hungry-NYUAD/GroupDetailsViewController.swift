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
    var orderGroupObject : OrderGroup!
    
    @IBOutlet weak var orderGroupRestaurant: UILabel!
    @IBOutlet weak var orderGroupName: UILabel!
    @IBOutlet weak var orderGroupId: UILabel!
    @IBOutlet weak var orderGroupNumber: UILabel!
    @IBOutlet weak var joinGroup: UIButton!
    
    @IBAction func joinOrderGroup(_ sender: Any) {
        //put the join order group function in here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print((orderGroupObject?.hasReachedCapacity).debugDescription)
        print(orderGroupObject.name)
        
        if (orderGroupObject?.hasReachedCapacity == true) {
            self.joinGroup.isHidden = true
        }
        
        self.orderGroupId.text = orderGroupObject?.id
        self.orderGroupName.text = orderGroupObject?.name
        self.orderGroupRestaurant.text = orderGroupObject?.restaurant
        self.orderGroupNumber.text = String(describing: orderGroupObject!.numMembers)
    
    }
    
    func joinGroupFunc() {
        var currentUserId : String = (Auth.auth().currentUser?.uid)!
        
        
    }
    
}
