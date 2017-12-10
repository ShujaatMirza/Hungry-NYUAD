//
//  OrderDetailsViewController.swift
//  Hungry-NYUAD
//
//  Created by Shujaat Mirza on 12/7/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase

class OrderDetailsViewController: UIViewController {
    var orderGroupObject : OrderGroup!


    @IBOutlet weak var orderGroupNameLabel: UILabel!
    @IBOutlet weak var orderGroupStatusLabel: UILabel!
    @IBOutlet weak var orderGroupRestaurantLabel: UILabel!
    
    //programatically created Button
    @objc func buttonAction(sender: UIButton!) {
        let btnsendtag: UIButton = sender
        btnsendtag.isHidden = true
        
        let newbtn: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 250, height: 70))
        newbtn.backgroundColor = UIColor.blue
       
        if btnsendtag.tag == 1 {
            Constants.refs.databaseOrderGroup.child(orderGroupObject.id).updateChildValues(["IsPlaced": true])
            newbtn.setTitle("Order Delivered ?", for: .normal)
            newbtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            newbtn.tag = 2
            self.view.addSubview(newbtn)
        }
        if btnsendtag.tag == 2{
            Constants.refs.databaseOrderGroup.child(orderGroupObject.id).updateChildValues(["IsDelivered": true])
            newbtn.setTitle("Order Completed ?", for: .normal)
            newbtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            newbtn.tag = 3
            self.view.addSubview(newbtn)
        }
        if btnsendtag.tag == 3{
            Constants.refs.databaseOrderGroup.child(orderGroupObject.id).updateChildValues(["IsCompleted": true])
            newbtn.setTitle("Bye", for: .normal)
            newbtn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            newbtn.tag = 4
            self.view.addSubview(newbtn)
        }
        if btnsendtag.tag == 4{
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "ListMyOrderGroupsIdentifier") as! ListMyOrderGroups
            self.present(newViewController, animated: true, completion: nil)
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Create a button to place order only if it is owner trying to access it and if the order has not been placed

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
        let btn: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 250, height: 70))
        btn.backgroundColor = UIColor.blue
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
            btn.isHidden = false
            self.view.addSubview(btn)
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

