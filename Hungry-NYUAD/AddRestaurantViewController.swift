//
//  AddRestaurantViewController.swift
//  Hungry-NYUAD
// A single viewcontroller for adding restaurants to the database. Must set application to start from this view controller.
//
//  Created by Mawutor Ama Abalo on 11/24/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

class AddRestaurantViewController: UIViewController {
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var hours: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var website: UITextField!
    
    var ref:DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        ref = Database.database().reference()
    }
    
    func fieldsEmpty() -> Bool{
        return (name.text?.isEmpty)! || (hours.text?.isEmpty)! || (phone.text?.isEmpty)! || (website.text?.isEmpty)!
    }
    
    @IBAction func addRestaurant(_ sender: Any) {
        if (!fieldsEmpty()){
            let restaurantRef = ref.child("restaurants").childByAutoId()
            restaurantRef.child("name").setValue(name.text)
            restaurantRef.child("hours").setValue(hours.text)
            restaurantRef.child("phone").setValue(phone.text)
            restaurantRef.child("website").setValue(website.text)
            
            let menuRef = ref.child("menus").childByAutoId()
            menuRef.setValue("empty")
            let menuId = menuRef.key
            restaurantRef.child("menuId").setValue(menuId)
            
            
            website.text?.removeAll()
            hours.text?.removeAll()
            name.text?.removeAll()
            phone.text?.removeAll()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
