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
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;

        let databaseOrderGroupRef = Database.database().reference()

        databaseOrderGroupRef.child("order_group").observe(DataEventType.value, with: { (snapshot) in
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.orderGroups.removeAll()
                
                //iterating through all the values
                for ordergroups in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let ordergroupObject = ordergroups.value as? [String: AnyObject]
                    var isMember = false
                    var listofmembers = ordergroupObject?["members"] as? [String : Bool]
                    
                    //Condition to check if user id the member of the group
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
                        
                        let orderGroup = OrderGroup(id: (ordergroupId as! String?)!, name: (ordergroupName as! String?)!, restaurant: (ordergroupRestaurant as! String?)!, ownerId: (ordergroupOwnerId as! String?)!, IsPlaced: (ordergroupIsPlaced as! Bool?)!, IsDelivered: (ordergroupIsDelivered as! Bool?)!, IsCompleted: (ordergroupIsCompleted as! Bool?)!, hasReachedCapacity: (ordergrouphasReachedCapacity as! Bool?)!, numMembers: (ordergroupnumMembers as! Int?)!
                        )
                        
                        //self.orderGroupObjectToSend = orderGroup
                        //print("The object capacity is as follows " + (self.orderGroupObjectToSend?.hasReachedCapacity.description)!)
                        //appending it to list
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
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return orderGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = "ListMyOrderGroupsTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? ListMyOrderGroupsTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ListMyOrderGroupsTableViewCell.")
        }
        // Fetches the appropriate meal for the data source layout.
        let orderGroup = orderGroups[indexPath.row]
        
        cell.idLabel.text = orderGroup.id
        cell.restaurantLabel.text = orderGroup.restaurant
        cell.OrderNameLabel.text = orderGroup.name
        
        
        //setting the data to pass to the next view-controller to the restaurant name
        
        return cell
    }
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showOrderDetails" {
            
            if let ExchangeViewData = segue.destination as? OrderDetailsViewController{
                //ExchangeViewData.orderGroupObject = self.orderGroupObjectToSend!
                let index = tableView.indexPathForSelectedRow?.row
                ExchangeViewData.orderGroupObject = orderGroups[index!]
                print("Hello")
                print(ExchangeViewData.orderGroupObject.id)
            }
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

