//
//  CostBreakdownTableViewCell.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/11/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class CostBreakdownTableViewCell: UITableViewCell {
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.price.textColor = UIColor.white
        self.name.textColor = UIColor.white
        self.backgroundColor = UIColor.clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
