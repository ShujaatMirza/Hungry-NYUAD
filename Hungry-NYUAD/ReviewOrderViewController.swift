//
//  ReviewOrderViewController.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/10/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

class ReviewOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var orderTotal: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var selectedItems: [MenuItem : Int]?
    var currentRestaurant: Restaurant?
    var orderGroupObject: OrderGroup?
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        ref = Database.database().reference()
        var total = 0.0
        for (key, val) in selectedItems! {
            total = total + (Double(val) * key.price)
        }
        
        self.orderTotal.text = String(total)
        setTableViewBackgroundGradient(sender: self, cgColor(red: 248, green: 205, blue: 70), cgColor(red: 240, green: 145, blue: 53))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func confirmOrder(_ sender: Any) {
        if !(currentRestaurant?.name.isEmpty)!{
            self.performSegue(withIdentifier: "toCreateGroup", sender: self)
        }
        else {
            let user = Auth.auth().currentUser!
            var listedOrders: [String : Any] = [:]
            for (key, val) in selectedItems! {
                let temp = ["name": key.name,
                            "count": val,
                            "price": val * Int(key.price)] as [String : Any]
                listedOrders[key.id] = temp
            }
            
            let myOrders = [user.uid : listedOrders]
            let myInfo = ["name": orderGroupObject?.name,
                          "restaurant": orderGroupObject?.restaurant,
                          "orderDate": orderGroupObject?.orderDate,
                          "order": listedOrders] as [String : Any]
            
            
            // Then write info:
            if let key = orderGroupObject?.id {
                let childUpdates = ["/order_group/\(key)/members/\(user.uid)/": listedOrders,
                                    "/users/\(user.uid)/order_groups/\(key)": myInfo]
                ref.updateChildValues(childUpdates)
                self.navigationController?.popToRootViewController(animated: true)
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreateGroup" {
            let destVC = segue.destination as! CreateNewGroupViewController
            destVC.selectedItems = selectedItems
            destVC.currentRestaurant = currentRestaurant
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? ReviewOrderTableViewCell else {
            fatalError("The dequeued cell is not an instance of ReviewOrderTableViewCell.")
        }
        guard let items = selectedItems else {
            fatalError("The dequeued cell is not an instance of MenuTableViewCell.")
        }
        print(selectedItems?.count ?? 0)
        let key = Array(items.keys)[indexPath.row]
        let val: Int! = items[key]
        cell.nameLabel.text = "x" + String(val) + " " + key.name
        
        let price = key.price * Double(val!)
        cell.priceLabel.text = String(price)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedItems?.count ?? 0
    }
}
