//
//  CreateNewGroupVC.swift
//  Hungry-NYUAD
//
//  Created by Muhammad Mirza on 11/18/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

class CreateNewGroupVC: UITableViewController {
    var dataToSend = [String: Any]()
    var orderGroup: OrderGroup!
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewBackgroundGradient(sender: self, cgColor(red: 10, green: 143, blue: 173), cgColor(red: 34, green: 69, blue: 145))
        self.hideKeyboardWhenTappedAround()
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;
        refOrderGroups = Constants.refs.databaseOrderGroup
    }
    //MARK: Properties
    //defining firebase reference var
    var refOrderGroups: DatabaseReference!
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var restaurantNameTextField: UITextField!

    @IBAction func createOrderGroup(_ sender: UIButton) {
        addGroup()
        
       self.performSegue(withIdentifier: "toSelectRestaurant", sender: self)
    }

    func addGroup(){
        let key = refOrderGroups.childByAutoId().key
        let group = ["id":key,
                      "name": groupNameTextField.text! as String,
                      "restaurant": restaurantNameTextField.text! as String,
                      "ownerId": Auth.auth().currentUser?.uid,
                      "IsPlaced": false,
                      "IsDelivered": false,
                      "IsCompleted": false,
                      "hasReachedCapacity": false,
                      "numMembers": 1
            ] as [String : Any]
        
        let name = groupNameTextField.text! as String
        let restaurant = restaurantNameTextField.text! as String
        let ownerId = Auth.auth().currentUser!.uid
        let IsPlaced = false
        let IsDelivered = false
        let IsCompleted = false
        let hasReachedCapacity = false
        let numMembers = 0
        
        let orderGroup = OrderGroup(id: key,
                                    name: name,
                                    restaurant: restaurant,
                                    ownerId: ownerId,
                                    IsPlaced: IsPlaced,
                                    IsDelivered: IsDelivered,
                                    IsCompleted: IsCompleted,
                                    hasReachedCapacity: hasReachedCapacity,
                                    numMembers: numMembers,
                                    menuId: "",
                                    orderDate: ""
        )
        
        self.orderGroup = orderGroup
        
        refOrderGroups.child(key).setValue(group)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toSelectRestaurant" {
            print("Performing Segue")
            if let selectRestaurant = segue.destination as? SelectRestaurant{
                selectRestaurant.orderGroup = self.orderGroup
            }
            
        }
        if segue.identifier == "transferGroupData" {
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
