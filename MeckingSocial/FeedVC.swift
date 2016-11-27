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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate=self
        tableView.dataSource=self
        
    }
    
    // TableView Stuff -------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return UITableViewCell()
        return tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
    }
    
    // TableView Stuff -------------------------------------------
    
    
    

    @IBAction func SignOutPressed(_ sender: AnyObject) {
        //let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("Steve: removed from keychain ")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }

}
