//
//  RestaurantMenuView.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/1/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

class RestaurantMenuView: UITableViewController, MaintainOrder {
    @IBOutlet weak var nextButton: UIBarButtonItem!
    var ref: DatabaseReference!
    var currentRestaurant: Restaurant?
    var listOfItems: [MenuItem : Int] = [:]
    var sectionCount: Int = 0
    var sectionItemCount: [Int] = []
    var sectionHeaders: [String] = []
    var rowCount: Int = 0
    let reuseIdentifier = "reuseIdentifier"
    var menuItems: [MenuItem] = []
    var orderGroupObject: OrderGroup?
    
    func addItem(menuItem: MenuItem) {
        if let val = listOfItems[menuItem] {
            listOfItems[menuItem] = val + 1
        }
        else {
            listOfItems[menuItem] = 1
        }
        
        for (key, val) in listOfItems {
            print("\(key.name), \(val)")
        }
        nextButton.isEnabled = true
        print("Added")
    }
    
    func removeItem(menuItem: MenuItem) {
        if let val = listOfItems[menuItem] {
            let new = val - 1
            if (new == 0) {
                listOfItems.removeValue(forKey: menuItem)
            }
            else {
                listOfItems[menuItem] = new
            }
        }
        
        if listOfItems.isEmpty {
            nextButton.isEnabled = false
        }
        
        for (key, val) in listOfItems {
            print("\(key.name), \(key.price), \(val)")
        }
        print("Removing")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toReview" {
            let destVC = segue.destination as! ReviewOrderViewController
            destVC.selectedItems = listOfItems
            destVC.currentRestaurant = currentRestaurant
            destVC.orderGroupObject = orderGroupObject
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return !listOfItems.isEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        print("The menuID is: \(currentRestaurant?.menuId)")
        setTableViewBackgroundGradient(sender: self, cgColor(red: 163, green: 201, blue: 63), cgColor(red: 248, green: 205, blue: 70))

        
        
        // Retrieving menu for selected restaurant
        if let restaurant = currentRestaurant{
            ref.child("menus").child(restaurant.menuId).observeSingleEvent(of: .value, with: { snapshot in
                print("The number of categories is:\(Int(snapshot.childrenCount))")
                self.sectionCount = Int(snapshot.childrenCount)
                var count = 0
                for category in snapshot.children.allObjects as! [DataSnapshot] {
                    self.sectionHeaders.append(category.key)
                    if count == 0 {
                        self.sectionItemCount.append(Int(category.childrenCount))
                    }
                    else{
                        self.sectionItemCount.append(Int(category.childrenCount) + self.sectionItemCount[count - 1])
                    }
                    print(Int(category.childrenCount))
                    for item in category.children.allObjects as! [DataSnapshot] {
                        let dItem = item.value as? NSDictionary
                        let menuItem  = MenuItem(name: dItem!["name"] as! String,
                                                 price: dItem!["price"] as! Double,
                                                 id: item.key )
                        self.menuItems.append(menuItem)
                    }
                    count = count + 1
                }
                
                self.tableView.reloadData()
            })
        }
        else {
            print("No such restaurant")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.sectionCount
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView {
        let v = UIView()
        v.backgroundColor = UIColor.clear
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 10, width:
            tableView.bounds.size.width, height: tableView.bounds.size.height))
        
        headerLabel.font = UIFont(name: "Verdana", size: 20)
        headerLabel.textColor = UIColor.darkGray
        headerLabel.text = self.tableView(self.tableView, titleForHeaderInSection: section)
        headerLabel.sizeToFit()
        v.addSubview(headerLabel)
        return v
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("There are, \(section),  \(sectionItemCount[section])")
        if section == 0 {
            return sectionItemCount[section]
        }
        else {
            return sectionItemCount[section] - sectionItemCount[section - 1]
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeaders[section]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? MenuTableViewCell else {
            fatalError("The dequeued cell is not an instance of MenuTableViewCell.")
        }
        var i: Int
        if indexPath.section == 0 {
            i = indexPath.row
        }
        else {
            i = sectionItemCount[indexPath.section - 1] + indexPath.row
        }
        
        // Configure the cell...
        cell.delegate = self
        cell.listOfItems = self.listOfItems
        cell.menuItem = menuItems[i]
        cell.itemName.text = menuItems[i].name
        cell.itemPrice.text = String(menuItems[i].price)
        
        return cell
    }

}
