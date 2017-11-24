//
//  ProfileView.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 11/20/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//
import UIKit
import GoogleSignIn
import Firebase

class ProfileView: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    var ref: DatabaseReference!
    var user: User!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        saveButton.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        
        self.profilePicture.frame.size.height = self.profilePicture.frame.size.width;
        
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
        self.profilePicture.clipsToBounds = true;
        ref = Database.database().reference()
        
        //let userID = Auth.auth().currentUser?.uid
        user = Auth.auth().currentUser
        ref.child("users").child((user?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.name.text = value?["name"] as? String ?? ""
            self.email.text = value?["email"] as? String ?? ""
            self.phone.text = value?["phone"] as? String ?? ""
            
            
             if let url = self.user?.photoURL {
                if let data = NSData(contentsOf: url) {
                    self.profilePicture.image = UIImage(data: data as Data)
                }
             }
     
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }

    @IBAction func save(_ sender: Any) {
        saveButton.isHidden = true
        editButton.isHidden = false
        name.isEnabled = false
        name.isSelected = false
        phone.isEnabled = false
        //email.isEnabled = false
        
        self.ref.child("users/\(self.user.uid)/name").setValue(name.text)
        //self.ref.child("users/\(self.user.uid)/email").setValue(user.email)
        self.ref.child("users/\(self.user.uid)/phone").setValue(phone.text)
    }
    
    @IBAction func edit(_ sender: Any) {
        editButton.isHidden = true
        saveButton.isHidden = false
        name.isEnabled = true
        name.isSelected = true
        phone.isEnabled = true
        //email.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
        return true
    }
    
    @IBAction func signOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        print("\nSign out clicked")
        let user = Auth.auth().currentUser
        //print(user)
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                //let uid = user.uid
                let email = user.email
                print(email ?? "")
                //let photoURL = user.photoURL
                // ...
            }
            self.performSegue(withIdentifier: "toBegin", sender: self)
            print("Signed out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)  // ...
        }
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

