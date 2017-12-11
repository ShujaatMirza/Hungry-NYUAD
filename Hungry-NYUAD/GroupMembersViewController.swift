//
//  GroupMembersViewController.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/11/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

class GroupMembersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var yourOrder: UITextView!
    @IBOutlet weak var tableView: UITableView!
    var orderGroupObject: OrderGroup!
    var ref: DatabaseReference!
    
    var names: [String : String] = [:]
    var costs: [String : Int] = [:]
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? CostBreakdownTableViewCell else {
            fatalError("The dequeued cell is not an instance of CostBreakdownTableViewCell.")
        }
        if indexPath.row == names.count {
            var total = 0
            for val in costs.values {
                total = total + val
            }
            cell.name.text = "Total"
            cell.price.text = String(total)
        }
        else {
            print(indexPath.row)
            print(costs.count)
            let key = Array(costs.keys)[indexPath.row]
            if key == Auth.auth().currentUser?.uid {
                cell.name.text = "You"
            }
            else {
                if let name = names[key] {
                    var txt = name
                    if key == orderGroupObject.ownerId {
                        txt = txt + " (Owner)"
                    }
                    cell.name.text = txt
                }
            }
            
            
            if let cost = costs[key] {
                cell.price.text = String(cost)
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return costs.count + 1
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        setTableViewBackgroundGradient(sender: self, cgColor(red: 163, green: 201, blue: 63), cgColor(red: 248, green: 205, blue: 70))
        
        ref = Database.database().reference()
        names.removeAll()
        costs.removeAll()
        print("The object is: an \(orderGroupObject)")
        ref.child("order_group").child(orderGroupObject.id).child("members").observeSingleEvent(of: .value, with: {snapshot in
            let count = snapshot.childrenCount
            var n = 0
            for member in snapshot.children.allObjects as! [DataSnapshot] {
                let key = member.key
                var orderSummary: String = ""
                for item in member.children.allObjects as! [DataSnapshot] {
                    if let dItem = item.value as? NSDictionary {
                        if (key == Auth.auth().currentUser?.uid) {
                            //var text = "x\(dItem["count"]) \(dItem["name"]) - \(dItem["price"])\n"
                        }
                        
                        let price = dItem["price"] as! Int
                        if let _ = self.costs[key] {
                            self.costs[key] = self.costs[key]! + price
                        }
                        else {
                            self.costs[key] = price
                        }
                    }
                }
                self.ref.child("users").child(key).child("name").observeSingleEvent(of: .value, with: {snapshot in
                    if let name = snapshot.value as? String {
                        self.names[key] = name
                        n = n + 1
                    }
                    if (n == count) {
                        self.tableView.reloadData()
                    }
                })
            }
        })
        
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
