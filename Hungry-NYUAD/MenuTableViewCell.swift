//
//  MenuTableViewCell.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/1/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var itemPrice: UILabel!
  
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var decrementButton: UIButton!
    @IBOutlet weak var incrementButton: UIButton!
    
    var count: Int = 0
    
    var menuItem: MenuItem?
    var listOfItems: [MenuItem : Int]!

    override func awakeFromNib() {
        super.awakeFromNib()
        count = 0
        // Initialization code
    }
    @IBAction func increment(_ sender: Any) {
        count = count + 1
        countLabel.text = String(count)
        print("\(menuItem?.name ?? "nil")")
        /*if let val = listOfItems[menuItem!] {
            listOfItems[menuItem!] = val + 1
        }
        else {
            listOfItems[menuItem!] = 0
        }
        */
        /*for (key, val) in listOfItems {
            print("\(key.name), \(val)")
        }*/
    }
    
    @IBAction func decrement(_ sender: Any) {
        if count > 0 {
            count = count - 1
            countLabel.text = String(count)
        }
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
