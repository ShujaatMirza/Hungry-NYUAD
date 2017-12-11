//
//  ListMyOrderGroupsTableViewCell.swift
//  Hungry-NYUAD
//
//  Created by Shujaat Mirza on 12/7/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class ListMyOrderGroupsTableViewCell: UITableViewCell {
    @IBOutlet weak var board: UIView! 
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var OrderNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        self.board.layer.masksToBounds = false
        self.board.layer.cornerRadius = 3
        self.board.layer.shadowColor = UIColor.black.cgColor
        self.board.layer.shadowOpacity = 0.5
        self.board.layer.shadowPath = UIBezierPath(rect: self.board.bounds).cgPath
        self.board.layer.shadowOffset = CGSize(width: -1, height: 3)

        // Configure the view for the selected state
    }

}

