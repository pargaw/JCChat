//
//  Profile.swift
//  JCChat
//
//  Created by Grace Lam on 11/5/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import Foundation
import UIKit

class Profile: UIViewController {
    
    @IBOutlet var mode:UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mode.selectedSegmentIndex = 1
    }
    
    @IBAction func modeState(sender:UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            
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