//
//  CreateNewGroupViewController.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/9/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

class CreateNewGroupViewController: UIViewController {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var createButton: ButtonBaseClass!
    @IBOutlet weak var orderDate: UITextField!
    @IBOutlet weak var groupName: UITextField!
    var ref: DatabaseReference!
    
    var selectedItems: [MenuItem : Int]?
    var currentRestaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewBackgroundGradient(sender: self, cgColor(red: 240, green: 145, blue: 53), cgColor(red: 230, green: 73, blue: 37))
        self.hideKeyboardWhenTappedAround()
        ref = Database.database().reference()
    }
    
    // Do any additional setup after loading the view.
    @IBAction func beganEditingName(_ sender: Any) {
        nameLabel.text = "GROUP NAME"
    }
    
    // Input validation
    func isValid() -> Bool{
        var rval = true
        var nameErrorText: String = "GROUP NAME"
        var dateErrorText: String = "ORDER DATE"
        
        if let name = self.groupName.text{
            if name.isEmpty {
                nameErrorText = "GROUP NAME CANNOT BE EMPTY."
                rval = false
            }
            else if name.count > 50 {
                nameErrorText = "GROUP NAME CANNOT BE MORE THAN 50 CHARACTERS."
                rval = false
            }
        }
        
        if let date = self.orderDate.text{
            if date.isEmpty {
                dateErrorText = "ORDER DATE CANNOT BE EMPTY."
                rval = false
            }
        }
        nameLabel.text = nameErrorText
        dateLabel.text = dateErrorText
        return rval
    }
    
    @IBAction func create(_ sender: Any) {
        if !isValid() {
            return
        }
        
        // First construct info
        let c = ref.child("order_group").childByAutoId()
        let key = c.key
        let user = Auth.auth().currentUser!
        
        var listedOrders: [String : Any] = [:]
        
        for (key, val) in selectedItems! {
            let temp = ["name": key.name,
                        "count": val,
                        "price": val * Int(key.price)] as [String : Any]
            listedOrders[key.id] = temp
        }
        
        let myOrders = [user.uid : listedOrders] as [String : Any]
        let myInfo = ["name": groupName.text,
                      "restaurant": currentRestaurant?.name,
                      "orderDate": orderDate.text,
                      "order": listedOrders] as [String : Any]
        
        let post = ["id": key,
                    "members": myOrders,
                    "name": groupName.text,
                    "IsCompleted": false,
                    "IsDelivered": false,
                    "IsPlaced": false,
                    "orderDate": orderDate.text,
                    "hasReachedCapacity": false,
                    "numMembers": 1,
                    "ownerId": user.uid,
                    "menuId": currentRestaurant?.menuId,
                    "restaurant": currentRestaurant?.name] as [String : Any]
        
        // Then write info:
        let childUpdates = ["/order_group/\(key)/": post,
                            "/users/\(user.uid)/order_groups/\(key)": myInfo]
        ref.updateChildValues(childUpdates)
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func editingOrderDate(_ sender: UITextField) {
        dateLabel.text = "ORDER DATE"
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        datePickerView.minimumDate = NSDate() as Date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        orderDate.text = dateFormatter.string(from: sender.date)
    }
    
}
