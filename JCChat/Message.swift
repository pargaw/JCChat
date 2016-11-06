//
//  Message.swift
//  JCChat
//
//  Created by Jamar Brooks on 11/5/16.
//  Copyright © 2016 Grace Lam. All rights reserved.
//

import Foundation

class Message {
    var from : String!
    var text : String!
    var timestamp : Double!
    
    init(from : String, text: String, timestamp: Double) {
        self.from = from
        self.text = text
        self.timestamp = timestamp
    }
}