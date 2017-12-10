//
//  CreateNewGroupViewController.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 12/9/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit

class CreateNewGroupViewController: UIViewController {
    @IBOutlet weak var orderDate: UITextField!
    @IBOutlet weak var groupName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewBackgroundGradient(sender: self, cgColor(red: 240, green: 145, blue: 53), cgColor(red: 230, green: 73, blue: 37))
        self.hideKeyboardWhenTappedAround()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editingOrderDate(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        
        datePickerView.datePickerMode = UIDatePickerMode.dateAndTime
        
        datePickerView.minimumDate = NSDate() as Date
        
        sender.inputView = datePickerView
        
        datePickerView.addTarget(self, action: #selector(CreateNewGroupViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.medium
        dateFormatter.timeStyle = DateFormatter.Style.short
        orderDate.text = dateFormatter.string(from: sender.date)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
