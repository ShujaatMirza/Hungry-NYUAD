//
//  RegistrationView.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 11/16/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//
import FirebaseAuthUI
import Firebase
import UIKit

class RegistrationView: UIViewController {
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var name: UITextField!
    
    var ref: DatabaseReference!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("here")
        // Do any additional setup after loading the view, typically from a nib.
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        name.text = user?.displayName ?? ""
    }
    
    @IBAction func submitDetails(_ sender: Any) {
        if let user = user{
            self.ref.child("users/\(user.uid)/name").setValue(user.displayName)
            self.ref.child("users/\(user.uid)/email").setValue(user.email)
            self.ref.child("users/\(user.uid)/phone").setValue(phone.text)
            performSegue(withIdentifier: "toLanding", sender: self)
        }
        else {
            print("No user signed in")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
