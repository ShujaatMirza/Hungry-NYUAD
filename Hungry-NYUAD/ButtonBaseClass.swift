//
//  ButtonBaseClass.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/9/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class ButtonBaseClass: UIButton {

    override func awakeFromNib() {
        self.setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "System", size: 16)
        self.frame.size = CGSize(width: 200, height: 45)
        self.center.x = (self.superview?.center.x)!
        layer.backgroundColor = UIColor.clear.cgColor
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.lightText.cgColor
        layer.cornerRadius = frame.size.height / 2;
        clipsToBounds = true;
    }
}
