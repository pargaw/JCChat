//
//  NewsfeedController.swift
//  JCChat
//
//  Created by Grace Lam on 11/5/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import Foundation
import UIKit

class NewsfeedController: UIViewController{
    
    @IBOutlet var home:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        home.layer.cornerRadius = 15
        home.layer.borderWidth = 1
        home.layer.borderColor = (UIColor( red: 0/255.0, green: 188/255.0, blue: 188/255.0, alpha: 1 )).CGColor
    }
    
    @IBAction func changeColorOnTouch(sender:UIButton) {
        home.backgroundColor = UIColor( red: 0/255.0, green: 188/255.0, blue: 188/255.0, alpha: 1 )
        home.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
}



