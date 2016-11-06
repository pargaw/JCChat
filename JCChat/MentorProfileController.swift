//
//  MentorProfileController.swift
//  JCChat
//
//  Created by Grace Lam on 11/5/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import Foundation
import UIKit

class MentorProfileController:UIViewController {
    
    @IBOutlet var back:UIButton!
    @IBOutlet var chat:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        back.layer.cornerRadius = 15
        back.layer.borderWidth = 1
        back.layer.borderColor = (UIColor( red: 0/255.0, green: 188/255.0, blue: 188/255.0, alpha: 1 )).CGColor
    }
    
    @IBAction func changeColorOnTouch(sender:UIButton) {
        back.backgroundColor = UIColor( red: 0/255.0, green: 188/255.0, blue: 188/255.0, alpha: 1 )
        back.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
    }
    
    @IBAction func goToMessage(sender:UIButton) {
        
    }

}
