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
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.backgroundColor = UIColor.clear
        
        self.contentView.backgroundColor = UIColor.clear
        self.board.layer.masksToBounds = false
        self.board.layer.cornerRadius = 3
        self.board.layer.shadowColor = UIColor.black.cgColor
        self.board.layer.shadowOpacity = 0.5
        self.board.layer.shadowPath = UIBezierPath(rect: self.board.bounds).cgPath
        self.board.layer.shadowOffset = CGSize(width: -1, height: 3)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
