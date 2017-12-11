//
//  OrderDetailsViewController.swift
//  Hungry-NYUAD
//
//  Created by Shujaat Mirza on 12/7/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

class OrderDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var orderDate: UILabel!
    var orderGroupObject : OrderGroup!
    var totalOrderCounts: [String : Int] = [:]
    var totalOrderPrice: [String : Int] = [:]
    var ref: DatabaseReference!


    @IBOutlet weak var orderGroupNameLabel: UILabel!
    @IBOutlet weak var orderGroupStatusLabel: UILabel!
    @IBOutlet weak var orderGroupRestaurantLabel: UILabel!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as? TotalOrderTableViewCell else {
            fatalError("The dequeued cell is not an instance of TotalOrderTableViewCell.")
        }
        //guard let items = selectedItems else {
          //  fatalError("The dequeued cell is not an instance of MenuTableViewCell.")
        //}
        
        
        
        if indexPath.row == totalOrderCounts.count {
            var total = 0
            for val in totalOrderPrice.values {
                total = total + val
            }
            cell.name.text = "Total"
            cell.price.text = String(total)
        }
        else {
            let key = Array(totalOrderCounts.keys)[indexPath.row]
            if let count = totalOrderCounts[key] {
                cell.name.text = "x\(count) \(key)"
            }
            
            if let price = totalOrderPrice[key] {
                cell.price.text = String(price)
            }
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return totalOrderCounts.count + 1
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toBreakdown" {
            let destVC = segue.destination as! GroupMembersViewController
            print("This is it\(orderGroupObject)")
            destVC.orderGroupObject = orderGroupObject
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    //programatically created Button
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        btnsendtag.isHidden = true
        
        //let newbtn = UIButton(type: .custom) as! ButtonBaseClass
        //let newbtn = ButtonBaseClass(type: .custom)
    
        let newbtn: UIButton = UIButton(frame: CGRect(x: 100, y: 550, width: 250, height: 70))
        newbtn.setTitleColor(UIColor.white, for: .normal)
        newbtn.frame.size = CGSize(width: 200, height: 45)
        
        newbtn.layer.backgroundColor = UIColor.clear.cgColor
        newbtn.layer.borderWidth = 2.0
        newbtn.layer.borderColor = UIColor.lightText.cgColor
        newbtn.layer.cornerRadius = newbtn.frame.size.height / 2;
        newbtn.clipsToBounds = true;
        //newbtn.backgroundColor = UIColor.blue
       
        if btnsendtag.tag == 1 {
            Constants.refs.databaseOrderGroup.child(orderGroupObject.id).updateChildValues(["IsPlaced": true])
            newbtn.setTitle("Order Delivered ?", for: .normal)
            newbtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            newbtn.tag = 2
            self.view.addSubview(newbtn)
            newbtn.center.x = (newbtn.superview?.center.x)!
        }
        if btnsendtag.tag == 2{
            Constants.refs.databaseOrderGroup.child(orderGroupObject.id).updateChildValues(["IsDelivered": true])
            newbtn.setTitle("Order Completed ?", for: .normal)
            newbtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            newbtn.tag = 3
            self.view.addSubview(newbtn)
            newbtn.center.x = (newbtn.superview?.center.x)!
        }
        if btnsendtag.tag == 3{
            Constants.refs.databaseOrderGroup.child(orderGroupObject.id).updateChildValues(["IsCompleted": true])
            newbtn.setTitle("Bye", for: .normal)
            newbtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            newbtn.tag = 4
            self.view.addSubview(newbtn)
            newbtn.center.x = (newbtn.superview?.center.x)!
        }
        if btnsendtag.tag == 4{
            
            //let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //let newViewController = storyBoard.instantiateViewController(withIdentifier: "ListMyOrderGroupsIdentifier") as! ListMyOrderGroups
            //self.present(newViewController, animated: true, completion: nil)
            self.navigationController?.popToRootViewController(animated: true)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialise tableview
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        ref = Database.database().reference()
        orderDate.text = "Order placed on " + orderGroupObject.orderDate 
        
        ref.child("order_group").child(orderGroupObject.id).child("members").observeSingleEvent(of: .value, with: {snapshot in
            for member in snapshot.children.allObjects as! [DataSnapshot] {
                for item in member.children.allObjects as! [DataSnapshot] {
                    if let dItem = item.value as? NSDictionary {
                        let name = dItem["name"] as! String
                        let count = dItem["count"] as! Int
                        let price = dItem["price"] as! Int
                        
                        if let _ = self.totalOrderCounts[name] {
                            self.totalOrderCounts[name] = self.totalOrderCounts[name]! + count
                            self.totalOrderPrice[name] = self.totalOrderPrice[name]! + price
                        }
                        else {
                            self.totalOrderCounts[name] = count
                            self.totalOrderPrice[name] = price
                            print("The price is \(price)")
                        }
                    }
                }
            }
            self.tableView.reloadData()
        })

        //Create a button to place order only if it is owner trying to access it and if the order has not been placed
        setTableViewBackgroundGradient(sender: self, cgColor(red: 10, green: 143, blue: 173), cgColor(red: 106, green: 156, blue: 105))
        RightButtonDisplay()
        self.orderGroupNameLabel.text = orderGroupObject?.name
        
        if((orderGroupObject?.IsCompleted) == true){
            self.orderGroupStatusLabel.text = "Order Completed"
        }else if((orderGroupObject?.IsDelivered) == true){
            self.orderGroupStatusLabel.text = "Order Delivered"
        }else if((orderGroupObject?.IsPlaced) == true){
            self.orderGroupStatusLabel.text = "Order Placed"
        }else{
            self.orderGroupStatusLabel.text = "In Progress"
        }
        self.orderGroupRestaurantLabel.text = orderGroupObject?.restaurant

    }
    
    func RightButtonDisplay(){
        let btn: UIButton = UIButton(frame: CGRect(x: 100, y: 550, width: 250, height: 70))
        btn.isHidden = false
        self.view.addSubview(btn)
        //btn.backgroundColor = UIColor.blue
        btn.setTitleColor(UIColor.white, for: .normal)
        btn.frame.size = CGSize(width: 200, height: 45)
        btn.center.x = (btn.superview?.center.x)!
        btn.layer.backgroundColor = UIColor.clear.cgColor
        btn.layer.borderWidth = 2.0
        btn.layer.borderColor = UIColor.lightText.cgColor
        btn.layer.cornerRadius = btn.frame.size.height / 2;
        btn.clipsToBounds = true;
        //let btn = ButtonBaseClass(type: .custom) as ButtonBaseClass
        if ((orderGroupObject?.ownerId == Auth.auth().currentUser?.uid)) {

            if(orderGroupObject?.IsPlaced == false){
                btn.setTitle("Place Order", for: .normal)
                btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                btn.tag = 1
                //self.view.addSubview(btn)
            }else if(orderGroupObject?.IsDelivered == false){
                btn.setTitle("Order Delivered ?", for: .normal)
                btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                btn.tag = 2
                //self.view.addSubview(btn)
            }else if(orderGroupObject?.IsCompleted == false){
                btn.setTitle("Order Completed ?", for: .normal)
                btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                btn.tag = 3
                //self.view.addSubview(btn)
            }else{
                btn.setTitle("Exit", for: .normal)
                btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
                btn.tag = 4
                //self.view.addSubview(btn)
            }
            
        } else {
            print("YOu don't own this")
            btn.isHidden = true
        }
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

