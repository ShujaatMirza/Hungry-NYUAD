//
//  RestaurantTableViewCell.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 11/24/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
class RestaurantTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hours: UILabel!
    @IBOutlet weak var board: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //restaurantNameLabel.font = UIFont(name: restaurantNameLabel.font.fontName, size: 20)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
