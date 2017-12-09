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
    var refOrderGroupMembers: DatabaseReference!
    
    @IBOutlet weak var orderGroupRestaurant: UILabel!
    @IBOutlet weak var orderGroupName: UILabel!
    @IBOutlet weak var orderGroupId: UILabel!
    @IBOutlet weak var orderGroupNumber: UILabel!
    
    @IBOutlet weak var joinOrderButton: UIButton!
    @IBAction func joinOrderGroup(_ sender: UIButton) {
        joinGroupFunc()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        refOrderGroupMembers = Constants.refs.databaseOrderGroupMembers
        print((orderGroupObject?.hasReachedCapacity).debugDescription)
        print(orderGroupObject.name)
        
        if (orderGroupObject?.hasReachedCapacity == true || (orderGroupObject.ownerId == Auth.auth().currentUser?.uid)) {
            self.joinOrderButton.isHidden = true
        }
        
        self.orderGroupId.text = orderGroupObject?.id
        self.orderGroupName.text = orderGroupObject?.name
        self.orderGroupRestaurant.text = orderGroupObject?.restaurant
        self.orderGroupNumber.text = String(describing: orderGroupObject!.numMembers)
    

    }
    func joinGroupFunc() {
        let currentUserId : String = (Auth.auth().currentUser?.uid)!
        let key = orderGroupObject.id
        let member = [currentUserId : true] as [String : Any]
        Constants.refs.databaseOrderGroup.child(key).child("members").setValue(member)
        
    }

    
}
