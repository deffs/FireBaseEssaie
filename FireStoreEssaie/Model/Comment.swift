//
//  Comment.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/13/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import Foundation
import Firebase

class Comment {
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var commentTxt: String!
    private(set) var docId: String!
    private(set) var userId: String!
    
    init(username: String, timestamp: Date, commentTxt: String, docId: String, userId: String) {
        self.username = username
        self.timestamp = timestamp
        self.commentTxt = commentTxt
        self.docId = docId
        self.userId = userId
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Comment] {
        var comments = [Comment]()
        guard let snap = snapshot else { return comments }
        for document in snap.documents {
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Anonymous"
            let timestamp = data[TIMESTAMP] as? Timestamp ?? Timestamp()
            let commentTxt = data[COM_TXT] as? String ?? ""
            let docId = document.documentID
            let userId = data[USER_ID] as? String ?? ""
            let date = timestamp.dateValue()
            
            let newComment = Comment(username: username, timestamp: date, commentTxt: commentTxt, docId: docId, userId: userId)
            comments.append(newComment)
        }
        
        return comments
    }
    
}
