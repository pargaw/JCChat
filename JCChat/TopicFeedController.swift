//
//  TopicFeedController.swift
//  JCChat
//
//  Created by Jamar Brooks on 11/8/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TopicFeedController: UITableViewController {
    
    var ref : FIRDatabaseReference!
    
    let postSpacingHeight : CGFloat = 20
    
    var currentRole : String!
    
    override func viewDidLoad() {
        ref = FIRDatabase.database().reference()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return postSpacingHeight
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 1
        }
        return 2
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 60
        } else {
            return 230
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCellWithIdentifier("postInputCell") as? PostInputCell {
                if currentRole == "Mentor" {
                    cell.rolePicture.image = UIImage(named: "Mentor")
                }
                return cell
            }
            
            return UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier("topicFeedCell", forIndexPath: indexPath)
            
            if let feedCell = cell as? NewsFeedCell {
                feedCell.postTitle.text = "True Love"
                feedCell.postTitle.text = "19 minutes ago"
                feedCell.usernameButton.setTitle("mtr716", forState: .Normal)
                feedCell.roleImage.image = UIImage(named: "Mentor")
                return feedCell
            }
            
            return cell
        }
    }
}
