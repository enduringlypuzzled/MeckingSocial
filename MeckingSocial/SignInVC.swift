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

class SignInVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Authenticate with Facebook
    @IBAction func fbBtnPressed(_ sender: AnyObject) {
    
        let facebookLogin = FBSDKLoginManager()
        
        facebookLogin.logIn(withReadPermissions: ["email"], from: self) { (result, error) in
            
            if error != nil {
                print("Steve:Unable to authenticate with Facebook - \(error)")
            }else if result?.isCancelled == true {
                print("Steve:User cancelled Facebook authentication")
            }else {
                print("Steve:Successfully authenticated with Facebook")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
                self.firebaseAuth(credential)
            }
        }
    
    
    }
    
    //Authenticate with FireBase
    func firebaseAuth(_ credential: FIRAuthCredential){
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            
            if error != nil {
                print("Steve: Unable to authenticate with Firebase")
            } else {
                print("Steve:Successfully authenticated with Firebase")
            }
        })
    }


}

