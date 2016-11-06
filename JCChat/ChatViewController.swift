//
//  MessageViewController.swift
//  JCChat
//
//  Created by Jamar Brooks on 11/5/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import FirebaseDatabase

class ChatViewController: JSQMessagesViewController {

    var chatId : String!
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor(red: 10/255, green: 180/255, blue: 230/255, alpha: 1.0))
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
    var messages = [JSQMessage]()
    
    var ref: FIRDatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()

        // Do any additional setup after loading the view.
        self.setup()
        self.loadMessages()

        self.navigationItem.title = chatId
        //self.addDemoMessages()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadMessagesView() {
        self.collectionView?.reloadData()
    }

    func loadMessages() {
        var chat = ref.child("chats").child(chatId)
        chat.observeSingleEventOfType(FIRDataEventType.Value, withBlock: { snapshot in
            
            if snapshot.value is NSNull {
                
            } else {
                print(snapshot.value)
                let value = snapshot.value as! NSDictionary
                for (key, val) in value {
                    if (key as! String == "last_message") {
                        print(val)
                    }
                    else if (key as! String == "last_message_timestamp") {
                        
                    } else {
                        let chatValue = val as! NSDictionary
                        let chatMessage = Message(from: chatValue["from"] as! String, text: chatValue["text"] as! String, timestamp: chatValue["timestamp"] as! Double)
                        let message = JSQMessage(senderId: chatMessage.from, displayName: chatMessage.from, text: chatMessage.text as String)
                        self.messages += [message]
                    }
                }
                self.reloadMessagesView()
            }
        })
        //let message = JSQMessage(senderId: "menteetemp1", displayName: "menteetemp1", text: "Hello, I have a question I was wondering if you could answer?")
        //self.messages += [message]

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//MARK - Setup
extension ChatViewController {
    func addDemoMessages() {
        for i in 1...10 {
            let sender = (i%2 == 0) ? "Server" : self.senderId
            let messageContent = "Message nr. \(i)"
            let message = JSQMessage(senderId: sender, displayName: sender, text: messageContent)
            self.messages += [message]
        }
        self.reloadMessagesView()
        print("eqwrtrytuyrerwe")
    }
    
    func setup() {
        self.senderId = UIDevice.currentDevice().identifierForVendor?.UUIDString
        self.senderDisplayName = UIDevice.currentDevice().identifierForVendor?.UUIDString
    }
}

//MARK - Data Source
extension ChatViewController {
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, didDeleteMessageAtIndexPath indexPath: NSIndexPath!) {
        self.messages.removeAtIndex(indexPath.row)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let data = messages[indexPath.row]
        switch(data.senderId) {
        case self.senderId:
            return self.outgoingBubble
        default:
            return self.incomingBubble
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
}

//MARK - Toolbar
extension ChatViewController {
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let message = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        self.messages += [message]
        self.finishSendingMessage()
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
    }
}
