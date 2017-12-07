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
        if btnsendtag.tag == 1 {
            //do Firbase Databse Chnages here and show appropriate confirmation message
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print((orderGroupObject?.hasReachedCapacity).debugDescription)
        print(orderGroupObject?.name)
        
        //Create a button to place order only if it is owner trying to access it and if the order has not been placed
        if ((orderGroupObject?.ownerId == Auth.auth().currentUser?.uid) && (orderGroupObject?.IsPlaced == false)) {
            let btn: UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 150, height: 50))
            btn.backgroundColor = UIColor.blue
            btn.setTitle("Place Order", for: .normal)
            btn.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            btn.tag = 1
            self.view.addSubview(btn)
        }

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

