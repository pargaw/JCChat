//
//  MessageTableViewController.swift
//  JCChat
//
//  Created by Jamar Brooks on 11/5/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import UIKit
import FirebaseDatabase

class MessageTableViewController: UITableViewController {

    var yourChats = [Chat]()
    
    var ref: FIRDatabaseReference!
    
    var currentUsername : String = "j316"
    
    var fromHome : Bool = true
    
    var currentRole : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        if (fromHome) {
          self.navigationItem.leftBarButtonItem = nil
        }
        populateRealChats()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateRealChats() {
        let chats = ref.child("chats")
        chats.observeSingleEventOfType(FIRDataEventType.Value, withBlock: { snapshot in
            
            if snapshot.value is NSNull {
                
            } else {
                let value = snapshot.value as! NSDictionary
                for (key, val) in value {
                    let chatId = key as! String
                    if (chatId.containsString(self.currentUsername)) {
                        let chat = Chat(title: chatId)
                        let last_message = val["last_message"] as! String
                        chat.postMessage(self.currentUsername, text: last_message)
                        self.yourChats.append(chat)
                    }
                }
            }
            self.tableView.reloadData()
        })

    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return yourChats.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("chatPreviewCell", forIndexPath: indexPath)

        // Configure the cell...
        cell.textLabel?.text = yourChats[indexPath.row].title
        cell.detailTextLabel?.text = "Last Updated by: \(yourChats[indexPath.row].last_updated_by) \(yourChats[indexPath.row].last_message)"

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //if let nav = segue.destinationViewController as? UINavigationController {
            if let destination = segue.destinationViewController as? ChatViewController {
                destination.chatId = self.tableView.cellForRowAtIndexPath(self.tableView.indexPathForSelectedRow!)!.textLabel!.text!
            }
        //}
    }
 

}
