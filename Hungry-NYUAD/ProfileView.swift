//
//  ProfileView.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 11/20/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//
import UIKit
import Firebase

class ProfileView: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    
override func viewDidLoad() {
    super.viewDidLoad()
    print("here1")
    // Do any additional setup after loading the view, typically from a nib.
    
    self.profilePicture.frame.size.height = self.profilePicture.frame.size.width;
    self.profilePicture.layer.cornerRadius = self.profilePicture.frame.size.width / 2;
    self.profilePicture.clipsToBounds = true;
    ref = Database.database().reference()
    
    //let userID = Auth.auth().currentUser?.uid
    let user = Auth.auth().currentUser
    ref.child("users").child((user?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
        // Get user value
        let value = snapshot.value as? NSDictionary
        self.name.text = value?["name"] as? String ?? ""
        self.email.text = value?["email"] as? String ?? ""
        self.phone.text = value?["phone"] as? String ?? ""
        
        
         if let url = user?.photoURL {
            if let data = NSData(contentsOf: url) {
                self.profilePicture.image = UIImage(data: data as Data)
            }
         }
 
 
    }) { (error) in
        print(error.localizedDescription)
    }
    
}



override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

}

