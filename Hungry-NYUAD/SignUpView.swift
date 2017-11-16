//
//  ViewController.swift
//  Hungry-NYUAD
//
//  Created by Mawutor Ama Abalo on 11/15/17.
//  Copyright © 2017 Software Engineering Group. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuthUI
import FirebaseGoogleAuthUI
import FirebaseFacebookAuthUI
import FirebaseTwitterAuthUI
import FirebasePhoneAuthUI
import GoogleSignIn


class SignUpView: UIViewController, GIDSignInUIDelegate {
    @IBOutlet weak var signOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func signOut(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        print("\nSign out clicked")
        let user = Auth.auth().currentUser
        //print(user)
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Signed out")
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                //let uid = user.uid
                let email = user.email
                print(email)
                //let photoURL = user.photoURL
                // ...
            }
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)  // ...
        }
        
       
        
    }
    
   

}


