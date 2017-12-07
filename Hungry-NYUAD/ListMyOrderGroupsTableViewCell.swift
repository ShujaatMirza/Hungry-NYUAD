//
//  ListMyOrderGroupsTableViewCell.swift
//  Hungry-NYUAD
//
//  Created by Shujaat Mirza on 12/7/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class ListMyOrderGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var OrderNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

