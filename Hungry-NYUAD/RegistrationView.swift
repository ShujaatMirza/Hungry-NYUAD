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

class RegistrationView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var name: UITextField!
    
    var ref: DatabaseReference!
    var user: User?
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        print("retfghjgj")
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("here")
        // Do any additional setup after loading the view, typically from a nib.
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        name.delegate = self
        name.text = user?.displayName ?? ""
        phone.returnKeyType = UIReturnKeyType.done
    }
    
    @IBAction func submitDetails(_ sender: Any) {
        if let user = user{
            self.ref.child("users/\(user.uid)/name").setValue(user.displayName)
            self.ref.child("users/\(user.uid)/email").setValue(user.email)
            self.ref.child("users/\(user.uid)/phone").setValue(phone.text)
            //performSegue(withIdentifier: "toLanding", sender: self)
            
            print("Auth in keychain")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "landing")
            self.present(vc, animated: true, completion: nil)
 
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
