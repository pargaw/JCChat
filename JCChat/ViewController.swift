//
//  ViewController.swift
//  JCChat
//
//  Created by Grace Lam on 11/5/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let tabController = segue.destinationViewController as? UITabBarController {
            for var controller in tabController.childViewControllers {
                if let home = controller as? HomeController {
                    let button = sender as! UIButton
                    home.currentRole = button.titleLabel?.text
                }
            }
        }
    }
}

