//
//  ListOrderGroupsTableViewController.swift
//  Hungry-NYUAD
//
//  Created by Andrew Callender on 11/19/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

 class ListOrderGroupsTableViewController: UITableViewController {
    
    var orderGroupObjectToSend : OrderGroup? = nil
    var orderGroups = [OrderGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewBackgroundGradient(sender: self, cgColor(red: 10, green: 143, blue: 173), cgColor(red: 34, green: 69, blue: 145))
        self.hideKeyboardWhenTappedAround()
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        
        let databaseRef = Database.database().reference().child("order_group")
        databaseRef.observe(DataEventType.value, with: { (snapshot) in
            
            if snapshot.childrenCount > 0 {
                
                self.orderGroups.removeAll()
                
                //iterating through all the values
                for ordergroups in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let ordergroupObject = ordergroups.value as? [String: AnyObject]
                    
                    
                    //Condition to check if user id the member of the group
                    var isMember = false
                    var listofmembers = ordergroupObject?["members"] as? [String : Any]
                    if listofmembers != nil {
                        for (key, value) in listofmembers! {
                            if(key ==  Auth.auth().currentUser?.uid){
                                isMember = true
                                print("Sorry")
                            }
                        }
                    }
                    if (((ordergroupObject?["ownerId"] as! String) != Auth.auth().currentUser?.uid) && isMember == false){

                        let ordergroupName  = ordergroupObject?["name"]
                        let ordergroupId  = ordergroupObject?["id"]
                        let ordergroupRestaurant = ordergroupObject?["restaurant"]
                        let ordergroupOwnerId = ordergroupObject?["ownerId"]
                        let ordergroupIsPlaced = ordergroupObject?["IsPlaced"]
                        let ordergroupIsDelivered = ordergroupObject?["IsDelivered"]
                        let ordergroupIsCompleted = ordergroupObject?["IsCompleted"]
                        let ordergrouphasReachedCapacity = ordergroupObject?["hasReachedCapacity"]
                        let ordergroupnumMembers = ordergroupObject?["numMembers"]
                        var ordergroupMenuId = ""
                        var ordergroupOrderDate = ""
                        
                        if let date = ordergroupObject?["orderDate"] {
                            ordergroupOrderDate = date as! String
                        }
                        
                        if let id = ordergroupObject?["menuId"] {
                            ordergroupMenuId = id as! String
                        }
                        
                        
                        let orderGroup = OrderGroup(id: (ordergroupId as! String?)!, name: (ordergroupName as! String?)!, restaurant: (ordergroupRestaurant as! String?)!, ownerId: (ordergroupOwnerId as! String?)!, IsPlaced: (ordergroupIsPlaced as! Bool?)!, IsDelivered: (ordergroupIsDelivered as! Bool?)!, IsCompleted: (ordergroupIsCompleted as! Bool?)!, hasReachedCapacity: (ordergrouphasReachedCapacity as! Bool?)!, numMembers: (ordergroupnumMembers as! Int?)!, menuId: ordergroupMenuId as! String, orderDate: ordergroupOrderDate
                        )
                        self.orderGroups.append(orderGroup!)
                    }
                }
                
                //reloading the tableview
                self.tableView.reloadData()
            }
            print(self.orderGroups.count)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }



    override func numberOfSections(in tableView: UITableView) -> Int {
        return orderGroups.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Set the spacing between sections
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    // Make the background color show through
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "OrderGroupTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? OrderGroupTableViewCell  else {
            fatalError("The dequeued cell is not an instance of OrderGroupTableViewCell.")
        }
        // Fetches the appropriate meal for the data source layout.
        let orderGroup = orderGroups[indexPath.section]
        
        cell.backgroundColor = UIColor.clear
        
        cell.restaurantLabel.text = orderGroup.restaurant
        cell.orderNameLabel.text = orderGroup.name
        
        
        //setting the data to pass to the next view-controller to the restaurant name
        
        return cell
    }
    
    
    // MARK: - Navigation
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showGroupData" {
            
            if let ExchangeViewData = segue.destination as? GroupDetailsViewController{
                let index = tableView.indexPathForSelectedRow?.section
                ExchangeViewData.orderGroupObject = orderGroups[index!]
                print(ExchangeViewData.orderGroupObject.id)
                print(ExchangeViewData.orderGroupObject.restaurant)
                print(ExchangeViewData.orderGroupObject.hasReachedCapacity.description)
            }
        }
    
   }

}
