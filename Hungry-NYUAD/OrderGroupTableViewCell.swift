//
//  OrderGroupTableViewCell.swift
//  Hungry-NYUAD
//
//  Created by Andrew Callender on 11/19/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class OrderGroupTableViewCell: UITableViewCell {
    
    @IBOutlet weak var board: UIView!
    //MARK: Properties
    @IBOutlet weak var restaurantLabel: UILabel!
    @IBOutlet weak var orderNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.restaurantLabel.textColor = UIColor.darkText
        self.orderNameLabel.textColor = UIColor.darkText
        self.selectionStyle = UITableViewCellSelectionStyle.none
        
        self.board.layer.masksToBounds = false
        self.board.layer.cornerRadius = 3
        self.board.layer.shadowColor = UIColor.black.cgColor
        self.board.layer.shadowOpacity = 0.5
        self.board.layer.shadowPath = UIBezierPath(rect: self.board.bounds).cgPath
        self.board.layer.shadowOffset = CGSize(width: -1, height: 3)
        //self.board.layer.shouldRasterize = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
