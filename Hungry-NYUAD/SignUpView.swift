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


class SignUpView: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var signInButton: GIDSignInButton!
    var ref: DatabaseReference!
    
    func navigationController(_ navigationController: UINavigationController,
                              willShow viewController: UIViewController,
                              animated: Bool){
        
        
        if viewController is RegistrationView{
            self.navigationController?.setNavigationBarHidden(false, animated: false)
        }
        else {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.delegate = self
        signInButton.colorScheme = GIDSignInButtonColorScheme.dark
        
        setTableViewBackgroundGradient(sender: self, cgColor(red: 10, green: 143, blue: 173), cgColor(red: 34, green: 69, blue: 145))
        
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            
            
            print("Auth in keychain")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "landing")
            self.present(vc, animated: true, completion: nil)
            
        }
        else {
            print("Auth not in keychain")
        }
        
        ref = Database.database().reference()
                
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        print("sign called")
        
        if let error = error {
            // ...
            print (error)
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                print(error)
                return
            }
            
            let user = Auth.auth().currentUser
            if let user = user {
                self.ref.child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    if snapshot.exists() {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "landing")
                        self.present(vc, animated: true, completion: nil)
                        
                    }
                    else {
                        self.performSegue(withIdentifier: "toRegistration", sender: self)
                    }
                }) { (error) in
                    print(error.localizedDescription) 
                }
            }
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
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
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            
            if let user = user {
                let email = user.email
                print(email ?? "")
            }
            print("Signed out")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)  // ...
        }
        
       
        
    }

}


