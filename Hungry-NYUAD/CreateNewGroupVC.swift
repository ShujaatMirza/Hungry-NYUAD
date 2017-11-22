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
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        //tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        self.tableView.estimatedRowHeight = 44.0;
        refOrderGroups = Constants.refs.databaseOrderGroup
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
    }

    func addGroup(){
        //generating a new key inside artists node
        //and also getting the generated key
        let key = refOrderGroups.childByAutoId().key
        //OrderGroup(id: key, name: groupNameTextField.text! as String, restaurant: restaurantNameTextField.text! as String)
        //creating order group with the given values
        let group = ["id":key,
                      "name": groupNameTextField.text! as String,
                      "restaurant": restaurantNameTextField.text! as String
        ]
        
        //adding the artist inside the generated unique key
        refOrderGroups.child(key).setValue(group)
        dataToSend = group
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        //Check your segue, this way you can transfer different data to different view. also make sure the identifier match your segue.
        if segue.identifier == "transferGroupData" {
            
            //Initial your second view data control
            if let ExchangeViewData = segue.destination as? OwnerOrderGroupVC{
                //Send your data with segue
                ExchangeViewData.dataToReceive = dataToSend
            }
            
            
        }
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
        return 3
    }
    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
