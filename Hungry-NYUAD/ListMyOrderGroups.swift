//
//  ListMyOrderGroups.swift
//  Hungry-NYUAD
//
//  Created by Shujaat Mirza on 12/7/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

class ListMyOrderGroups: UITableViewController {
    
    var orderGroupObjectToSend : OrderGroup? = nil
    var orderGroups = [OrderGroup]()
    var orderGroupsMembers = [OrderGroupMembers]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tableView.rowHeight = UITableViewAutomaticDimension;
        //self.tableView.estimatedRowHeight = 44.0;

        let databaseOrderGroupRef = Database.database().reference()
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        setTableViewBackgroundGradient(sender: self, cgColor(red: 10, green: 143, blue: 173), cgColor(red: 34, green: 69, blue: 145))

        databaseOrderGroupRef.child("order_group").observe(DataEventType.value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
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
                            }
                        }
                    }
                    
                    // condition if user is the owner)
                    if (((ordergroupObject?["ownerId"] as! String) == Auth.auth().currentUser?.uid) || isMember == true){
                        let ordergroupName  = ordergroupObject?["name"]
                        let ordergroupId  = ordergroupObject?["id"]
                        let ordergroupRestaurant = ordergroupObject?["restaurant"]
                        let ordergroupOwnerId = ordergroupObject?["ownerId"]
                        let ordergroupIsPlaced = ordergroupObject?["IsPlaced"]
                        let ordergroupIsDelivered = ordergroupObject?["IsDelivered"]
                        let ordergroupIsCompleted = ordergroupObject?["IsCompleted"]
                        let ordergrouphasReachedCapacity = ordergroupObject?["hasReachedCapacity"]
                        let ordergroupnumMembers = ordergroupObject?["numMembers"]
                        
                        var ordergroupDate = ""
                        if let id = ordergroupObject?["orderDate"] {
                            ordergroupDate = id as! String
                        }
                        
                        var ordergroupMenuId = ""
                        if let id = ordergroupObject?["menuId"] {
                            ordergroupMenuId = id as! String
                        }
                        
                        let orderGroup = OrderGroup(id: (ordergroupId as! String?)!, name: (ordergroupName as! String?)!, restaurant: (ordergroupRestaurant as! String?)!, ownerId: (ordergroupOwnerId as! String?)!, IsPlaced: (ordergroupIsPlaced as! Bool?)!, IsDelivered: (ordergroupIsDelivered as! Bool?)!, IsCompleted: (ordergroupIsCompleted as! Bool?)!, hasReachedCapacity: (ordergrouphasReachedCapacity as! Bool?)!, numMembers: (ordergroupnumMembers as! Int?)!, menuId: ordergroupMenuId, orderDate: ordergroupDate
                                                    
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return orderGroups.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
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
        let Cell = "ListMyOrderGroupsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListMyOrderGroupsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ListMyOrderGroupsTableViewCell.")
        }
        // Fetches the appropriate meal for the data source layout.
        let orderGroup = orderGroups[indexPath.section]
        
        cell.backgroundColor = UIColor.clear
        cell.restaurantLabel.text = orderGroup.restaurant
        cell.OrderNameLabel.text = orderGroup.name
        
        
        //setting the data to pass to the next view-controller to the restaurant name
        
        return cell
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOrderDetails" {
            
            if let ExchangeViewData = segue.destination as? OrderDetailsViewController{
                let index = tableView.indexPathForSelectedRow?.section
                ExchangeViewData.orderGroupObject = orderGroups[index!]
                print("Hello")
                print(ExchangeViewData.orderGroupObject.id)
            }
        }
        
    }
}

