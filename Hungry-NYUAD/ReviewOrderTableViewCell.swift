//
//  ReviewOrderTableViewCell.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/10/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class ReviewOrderTableViewCell: UITableViewCell {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.priceLabel.textColor = UIColor.white
        self.nameLabel.textColor = UIColor.white
        self.backgroundColor = UIColor.clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
