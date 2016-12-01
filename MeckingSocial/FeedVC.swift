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

class FeedVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageAdd: CircleView!
    
    var posts = [Post]()
    var imagePicker: UIImagePickerController!
    static var imageCache: NSCache<NSString, UIImage> = NSCache()
    //var imageSelected: Bool
   

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate=self
        tableView.dataSource=self
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self

        
        
        DataService.ds.REF_POSTS.observe(.value, with: { (snapshot) in
            //print(snapshot.value)
            
            if let snapshot = snapshot.children.allObjects as? [FIRDataSnapshot] {
                for snap in snapshot {
                    print("SNAP: \(snap)")
                    
                    if let postDict = snap.value as? Dictionary<String, AnyObject> {
                        
                        let key = snap.key
                        let post = Post(postKey: key, postData: postDict)
                        self.posts.append(post)
                        
                    }
                    
                }
            }
            self.tableView.reloadData()
        })
        
        
    }
    
    // TableView Stuff -------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return UITableViewCell()
        
        let post = posts[indexPath.row]
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as? PostCell {
            cell.configureCell(post: post)
            return cell
        } else {
                return PostCell()
        }
     
    }
    
    // imageView Stuff --------------------------------------------------------------------
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageAdd.image = image
            //imageSelected = true
        } else {
            print("Steve: A valid image wasn't selected")
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func addImagePressed(_ sender: AnyObject) {
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    
    
    
    //  ------------------------------------------------------------------------------------
    
    
    @IBAction func signOutPresses(_ sender: AnyObject) {
        //let keychainResult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! FIRAuth.auth()?.signOut()
        print("Steve: removed from keychain ")
        performSegue(withIdentifier: "goToSignIn", sender: nil)
    }

}
