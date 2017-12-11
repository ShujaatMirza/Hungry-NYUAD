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
    @IBOutlet weak var signOutButton: UIButton!
    
    var ref: DatabaseReference!
    var user: User!
    var isStranger: Bool = false
    var strangerUid: String?
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTableViewBackgroundGradient(sender: self, cgColor(red: 10, green: 143, blue: 173), cgColor(red: 34, green: 69, blue: 145))
        self.hideKeyboardWhenTappedAround()
        
        saveButton.isHidden = true
        var uid: String = ""
        if isStranger {
            // viewing someone else's profile
            editButton.isHidden = true
            signOutButton.isHidden = true
            uid = strangerUid!
        }
        else {
            // viewing your own profile
            user = Auth.auth().currentUser
            uid = (user?.uid)!
        }
        
        name.backgroundColor = UIColor.clear
        email.backgroundColor = UIColor.clear
        phone.backgroundColor = UIColor.clear
        
        name.borderStyle = UITextBorderStyle.none
        email.borderStyle = UITextBorderStyle.none
        phone.borderStyle = UITextBorderStyle.none
        
        
        self.profilePicture.frame.size.height = self.profilePicture.frame.size.width;
        self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
        self.profilePicture.clipsToBounds = true;
        
        // Get a reference to the database
        ref = Database.database().reference()
        
        
        ref.child("users").child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            self.name.text = value?["name"] as? String ?? ""
            self.email.text = value?["email"] as? String ?? ""
            self.phone.text = value?["phone"] as? String ?? ""
            
             if let url = self.user?.photoURL {
                print(url)
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
        
        name.borderStyle = UITextBorderStyle.none
        phone.borderStyle = UITextBorderStyle.none
        
        phone.textColor = UIColor.white
        name.textColor = UIColor.white
        
        name.backgroundColor = UIColor.clear
        email.backgroundColor = UIColor.clear
        phone.backgroundColor = UIColor.clear
        
        self.ref.child("users/\(self.user.uid)/name").setValue(name.text)
        self.ref.child("users/\(self.user.uid)/phone").setValue(phone.text)
    }
    
    // Only the phone number and name can be edited.
    @IBAction func edit(_ sender: Any) {
        editButton.isHidden = true
        saveButton.isHidden = false
        
        name.borderStyle = UITextBorderStyle.roundedRect
        phone.borderStyle = UITextBorderStyle.roundedRect
        
        name.backgroundColor = UIColor.white
        phone.backgroundColor = UIColor.white
        
        phone.textColor = UIColor.darkText
        name.textColor = UIColor.darkText
        
        name.isEnabled = true
        name.isSelected = true
        phone.isEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
        return true
    }
    
    @IBAction func signOut(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.performSegue(withIdentifier: "toBegin", sender: self)
            print("Signed out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)  // ...
        }
    }

}

extension UIViewController {
    
    // call this function so the keyboard doesn't hang around when the user is done typing.s
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // function for setting the background of a view
    func setTableViewBackgroundGradient(sender: UIViewController, _ topColor:CGColor, _ bottomColor:CGColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = sender.view.bounds
        gradientLayer.colors = [topColor,
                                bottomColor]
        
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)
        let newView = UIView(frame: sender.view.bounds)
        newView.layer.addSublayer(gradientLayer)
        if let senderT: UITableViewController = sender as? UITableViewController{
            senderT.tableView.backgroundView = newView
        } else {
        
        sender.view.addSubview(newView)
        sender.view.sendSubview(toBack: newView)
        
        }
    }
    
    func cgColor(red: CGFloat, green: CGFloat, blue: CGFloat) -> CGColor {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
    }
}

