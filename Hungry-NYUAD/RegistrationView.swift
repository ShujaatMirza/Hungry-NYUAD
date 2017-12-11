//
//  RegistrationView.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 11/16/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//
import FirebaseAuthUI
import Firebase
import GoogleSignIn
import UIKit

class RegistrationView: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var name: UITextField!
    
    var ref: DatabaseReference!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewBackgroundGradient(sender: self, cgColor(red: 10, green: 143, blue: 173), cgColor(red: 34, green: 69, blue: 145))
        self.hideKeyboardWhenTappedAround()
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        user = Auth.auth().currentUser
        ref = Database.database().reference()
        name.delegate = self
        name.text = user?.displayName ?? ""
        phone.returnKeyType = UIReturnKeyType.done
    }
    
    @IBAction func beganEditingName(_ sender: UITextField) {
        // clear any error text
        nameLabel.text = "NAME"
    }
    
    @IBAction func beganEditingPhone(_ sender: Any) {
        // clear any error text
        phoneLabel.text = "PHONE"
    }
    
    @IBAction func exitSignUp(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitDetails(_ sender: Any) {
        if let user = user{
            if !isValid() {
                return
            }
            self.ref.child("users/\(user.uid)/name").setValue(name.text)
            self.ref.child("users/\(user.uid)/email").setValue(user.email)
            self.ref.child("users/\(user.uid)/phone").setValue(phone.text)
            
            print("Auth in keychain")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "landing")
            self.present(vc, animated: true, completion: nil)
 
        }
        else {
            print("No user signed in")
        }
    }
    
    // validate input
    func isValid() -> Bool{
        var rval = true
        var nameErrorText: String = "NAME"
        var phoneErrorText: String = "PHONE"
        
        if let name = self.name.text{
            if name.isEmpty {
                nameErrorText = "NAME CANNOT BE EMPTY."
                rval = false
            }
            else if name.count > 50 {
                nameErrorText = "NAME CANNOT BE MORE THAN 50 CHARACTERS."
                rval = false
            }
        }
        
        if let phone = self.phone.text {
            if phone.isEmpty {
                phoneErrorText = "PHONE CANNOT BE EMPTY."
                rval = false
            }
            else if phone.count != 10 {
                phoneErrorText = "PHONE NUMBER MUST BE 10 DIGITS LONG."
                rval = false
            }
        }
        
        phoneLabel.text = phoneErrorText
        nameLabel.text = nameErrorText
        return rval
    }
    
    // Jump to next text field when return is clicked
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
