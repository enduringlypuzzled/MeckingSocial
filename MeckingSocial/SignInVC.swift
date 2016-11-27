//
//  ViewController.swift
//  MeckingSocial
//
//  Created by Steve Mecking on 2016-11-20.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    @IBOutlet weak var emailField: FancyField!
    @IBOutlet weak var pwField: FancyField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
    
        /*if let _ = KeychainWrapper.standard.string(forKey: KEY_UID) {
            performSegue(withIdentifier: "goToFeed", sender: nil)
            print("steve: this isn't working")
            
        }*/

    }

    /*
    //Authenticate with Facebook
    @IBAction func fbBtnPressed(_ sender: AnyObject) {
    
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("Steve: Unable to authenticate with Facebook - \(error)")
            }else if result?.isCancelled == true {
                print("Steve: User cancelled Facebook authentication")
            }else {
                print("Steve: Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    
    
    }*/
    
    //Authenticate with FireBase
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            
            if error != nil {
                print("Steve: Unable to authenticate with Firebase")
            } else {
                print("Steve:Successfully authenticated with Firebase")
                if let user = user {
                        self.completeSignIn(id: user.uid)
                }
            }
        })
    }

    // Sign in with Email
    @IBAction func signinBtnPressed(_ sender: AnyObject) {
        
        if let email = emailField.text, let pwd = pwField.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: pwd, completion: { (user, error) in
                
                if error == nil {
                    print("Steve: Email user authenticated with Firebase")
                } else {
                    FIRAuth.auth()?.createUser(withEmail: email, password: pwd, completion: { (user, error) in
                        if error != nil {
                            print("Steve: Unable to authenticate with Firebase")
                        }else {
                            print("Steve: Succesfully authenticated with Firebase")
                            if let user = user {
                                self.completeSignIn(id: user.uid)
                            }
                        }
                    })
                }
                
            })
            
        }
        
        
    }
    
    func completeSignIn(id: String){
        //KeychainWrapper.standard.set(id, forKey: KEY_UID)
        performSegue(withIdentifier: "goToFeed", sender: nil)
    }

}

