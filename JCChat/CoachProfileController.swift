//
//  Profile.swift
//  JCChat
//
//  Created by Grace Lam on 11/5/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class CoachProfileController: UIViewController {
    
    @IBOutlet var mode:UISegmentedControl!
    
    var currentUsername : String! = "mtr712"
    
    var ref : FIRDatabaseReference!
    
    var isMentor : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        loadProfile(currentUsername)
        
        mode.selectedSegmentIndex = 1
    }
    
    func loadProfile(username : String) {
        ref.child("users").child(username).observeSingleEventOfType(FIRDataEventType.Value, withBlock: { snapshot in
            
            if snapshot.value is NSNull {
                
            } else {
                print(snapshot.value)
                let value = snapshot.value as! NSDictionary
                
                if let roles = value["roles"] as? NSArray {
                    print(roles)
                    for val in roles {
                        print(val)
                        if (val as! String == "Mentor") {
                            self.isMentor = true
                        }
                    }
                }
            }
        })
    }
    
    @IBAction func modeState(sender:UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            if !isMentor {
                let alert = UIAlertController(title: "Become a Mentor", message: "To become a mentor, please apply on this link: www.JCchat.com/mentor", preferredStyle: .Alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .Default) { (action:UIAlertAction!) in
                    //print("you have pressed OK button");
                }
                alert.addAction(OKAction)
                
                self.presentViewController(alert, animated: true, completion:nil)
                
                mode.selectedSegmentIndex = 1
            }
        }
    }
    
}