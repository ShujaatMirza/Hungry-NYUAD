//
//  SelectRestaurant.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 11/24/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

class SelectRestaurant: UITableViewController {
    @IBOutlet var theTableView: UITableView!
    
    var selectedRestaurant: Restaurant?
    var orderGroup: OrderGroup?
    var ref: DatabaseReference!
    let reuseIdentifier = "reuseIdentifier"
    var rowCount: Int = 0
    var restaurantInfo: [Restaurant] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("restaurants").observeSingleEvent(of: .value, with: { snapshot in
            print("The count is\(Int(snapshot.childrenCount))")
            self.rowCount = Int(snapshot.childrenCount)
            self.restaurantInfo.removeAll()
            for rest in snapshot.children.allObjects as! [DataSnapshot] {
                let inf = rest.value as? NSDictionary
                let r = Restaurant(name: inf!["name"] as! String, hours: inf!["hours"] as! String, phone: inf!["phone"] as! String, website: inf!["website"] as! String, menuId: inf!["menuId"] as! String)
                self.restaurantInfo.append(r)
            }
            self.tableView.reloadData()
        })

        setTableViewBackgroundGradient(sender: self, cgColor(red: 10, green: 143, blue: 173), cgColor(red: 106, green: 156, blue: 105))
        
        print("Here")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSelectItems" {
            let destVC = segue.destination as! RestaurantMenuView
            destVC.currentRestaurant = selectedRestaurant
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.section).")
        selectedRestaurant = restaurantInfo[indexPath.section]
        self.performSegue(withIdentifier: "toSelectItems", sender: self)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.rowCount
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? RestaurantTableViewCell  else {
            fatalError("The dequeued cell is not an instance of RestaurantTableViewCell.")
        }
        
        // configure cell
        cell.hours.text = restaurantInfo[indexPath.section].hours
        cell.nameLabel.text = restaurantInfo[indexPath.section].name
        cell.backgroundColor = UIColor.clear
        cell.clipsToBounds = true

        return cell
    }
}
