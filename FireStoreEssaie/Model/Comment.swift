//
//  Comment.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/13/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import Foundation

class Comment {
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var commentTxt: String!
    
    init(username: String, timestamp: Date, commentTxt: String) {
        self.username = username
        self.timestamp = timestamp
        self.commentTxt = commentTxt
        
    }
}
