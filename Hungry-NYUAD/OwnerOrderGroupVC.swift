//
//  OwnerOrderGroupVC.swift
//  Hungry-NYUAD
//
//  Created by Muhammad Mirza on 11/19/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class OwnerOrderGroupVC: UITableViewController {
    var dataToReceive = [String: Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.OrderGroupLabel.text = dataToReceive["name"] as! String
        self.OrderGroupRestaurantLabel.text = dataToReceive["restaurant"] as! String
    }

    @IBOutlet weak var OrderGroupLabel: UILabel!
    @IBOutlet weak var OrderGroupRestaurantLabel: UILabel!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
