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
    
    var orderGroups = [OrderGroup]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let databaseRef = Database.database().reference().child("order_group")
        
        databaseRef.observe(DataEventType.value, with: { (snapshot) in
            
            //if the reference have some values
            if snapshot.childrenCount > 0 {
                
                //clearing the list
                self.orderGroups.removeAll()
                
                //iterating through all the values
                for ordergroups in snapshot.children.allObjects as! [DataSnapshot] {
                    //getting values
                    let ordergroupObject = ordergroups.value as? [String: AnyObject]
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
                    
                    //appending it to list
                    self.orderGroups.append(orderGroup!)
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderGroups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "OrderGroupTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? OrderGroupTableViewCell  else {
            fatalError("The dequeued cell is not an instance of OrderGroupTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let orderGroup = orderGroups[indexPath.row]
        
        cell.idLabel.text = orderGroup.id
        cell.restaurantLabel.text = orderGroup.restaurant
        cell.orderNameLabel.text = orderGroup.name
        
        return cell
    }
    
    
    // MARK: - Navigation
    
   // override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //if segue.identifier == "showDetail"
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
  //  }
 

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


}
