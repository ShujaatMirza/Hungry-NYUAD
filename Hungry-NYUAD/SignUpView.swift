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
import FirebasePhoneAuthUI
import GoogleSignIn


class SignUpView: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    @IBOutlet weak var signOutButton: UIButton!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        ref = Database.database().reference()
        
        //GIDSignIn.sharedInstance().signIn()
        
        // TODO(developer) Configure the sign-in button look/feel
        // ...
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        print("sign called")
        // ...
        
        if let error = error {
            // ...
            print (error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        // ...
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // ...
                print(error)
                return
            }
            print("Userr is signed in.")
            let user = Auth.auth().currentUser
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                //let uid = user.uid
                //let email = user.email
                //let displayName = user.displayName
                let photoURL = user.photoURL
                print(photoURL ?? "")
                //let photoURL = user.photoURL
                // ...
                
                // Make your segue here
                //self.performSegue(withIdentifier: "SignInSuccessful", sender: self)
            }
            //
            self.ref.child("users").child((user?.uid)!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                if snapshot.exists() {
                    self.performSegue(withIdentifier: "toLandingFromSignIn", sender: self)
                }
                else {
                    self.performSegue(withIdentifier: "toRegistration", sender: self)
                }
                
                
                
                
            }) { (error) in
                print(error.localizedDescription)
            }
            /*
            if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
 
                /*
                print("Auth in keychain")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "registrationView")
                self.present(vc, animated: true, completion: nil)
                */
            }
            else {
                print("Auth not in keychain")
             }*/
            
            // User is signed in
            // ...
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            print("Signed out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)  // ...
        }
    }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url, sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    
    @IBAction func signOut(_ sender: UIButton) {
        
        
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
            print("Signed out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)  // ...
        }
        
       
        
    }

}


