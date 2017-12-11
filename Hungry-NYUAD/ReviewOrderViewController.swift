//
//  ReviewOrderViewController.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/10/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class ReviewOrderViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var orderTotal: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var selectedItems: [MenuItem : Int]?
    var currentRestaurant: Restaurant?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.tableFooterView = UIView()
        
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
