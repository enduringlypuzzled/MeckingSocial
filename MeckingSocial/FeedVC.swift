//
//  FeedVC.swift
//  MeckingSocial
//
//  Created by Steve Mecking on 2016-11-26.
//  Copyright © 2016 Steve Mecking. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class FeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func SignOutPressed(_ sender: AnyObject) {
        //let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("Steve: removed from keychain ")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }

}
