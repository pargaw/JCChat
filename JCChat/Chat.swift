//
//  Chat.swift
//  JCChat
//
//  Created by Jamar Brooks on 11/5/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import Foundation

class Chat {
    var messages : [Message]!
    var last_message : String!
    var last_message_timestamp : Double!
    var last_updated_by : String!
    var title : String!
    
    init(title : String) {
        messages = [Message]()
        self.title = title
    }
    
    func postMessage(from: String, text: String) {
        let time = NSDate().timeIntervalSince1970
        messages.append(Message(from: from, text: text, timestamp: time))
        last_message = text
        last_message_timestamp = time
        last_updated_by = from
    }
}