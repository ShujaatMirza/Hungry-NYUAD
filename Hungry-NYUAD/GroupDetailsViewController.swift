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
    @IBOutlet weak var OrderDate: UILabel!
    @IBOutlet weak var joinOrderGroupButton: UIButton!
    
    @IBAction func joinOrderGroup(_ sender: UIButton) {
        joinGroupFunc()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelectItems" {
            let destVC = segue.destination as! RestaurantMenuView
            destVC.currentRestaurant = Restaurant(name: "", hours: "", phone: "", website: "", menuId: orderGroupObject.menuId)
            destVC.orderGroupObject = orderGroupObject
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refOrderGroupMembers = Constants.refs.databaseOrderGroupMembers
        print((orderGroupObject?.hasReachedCapacity).debugDescription)
        print(orderGroupObject.name)
        setTableViewBackgroundGradient(sender: self, cgColor(red: 10, green: 143, blue: 173), cgColor(red: 106, green: 156, blue: 105))
        if (orderGroupObject?.hasReachedCapacity == true || (orderGroupObject.ownerId == Auth.auth().currentUser?.uid)) {
            self.joinOrderGroupButton.isHidden = true
        }
        
        self.orderGroupName.text = orderGroupObject?.name
        self.orderGroupRestaurant.text = orderGroupObject?.restaurant
        self.OrderDate.text = "Expected Time:" + (orderGroupObject?.orderDate)!


    }
    func joinGroupFunc() {
        let currentUserId : String = (Auth.auth().currentUser?.uid)!
        let key = orderGroupObject.id
        //let member = [currentUserId : true] as [String : Any]
        
        
        
        //join the members of the group
        //Constants.refs.databaseOrderGroup.child(key).child("members").setValue(member)
        
        //incrmenet the num_memeber counter
        //let currentNumMebers = orderGroupObject.numMembers
        //Constants.refs.databaseOrderGroup.child(key).updateChildValues(["numMembers":(currentNumMebers+1)])
    
    }

    
}
