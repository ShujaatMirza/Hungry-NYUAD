//
//  BaseTextFieldClass.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/9/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class BaseTextFieldClass: UITextField {
    
    override func awakeFromNib() {
        self.textColor = UIColor.white
        layer.backgroundColor = UIColor.clear.cgColor
        
        self.attributedPlaceholder = NSAttributedString(string: "",
                                                        attributes: [NSAttributedStringKey.foregroundColor: UIColor.lightText])
        
        self.borderStyle = .none
        
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 1, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.lightText.cgColor
        self.borderStyle = UITextBorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}
