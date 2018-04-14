//
//  Thoughts.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/10/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import Foundation
import Firebase

class Thought {
    
    private(set) var username: String!
    private(set) var timestamp: Date!
    private(set) var thoughtTxt: String!
    private(set) var numLikes: Int!
    private(set) var numComments: Int!
    private(set) var docId: String!
    
    init(username: String, timestamp: Date, thoughtTxt: String, numLikes: Int, numComments: Int, docId: String) {
        self.username = username
        self.timestamp = timestamp
        self.thoughtTxt = thoughtTxt
        self.numLikes = numLikes
        self.numComments = numComments
        self.docId = docId
    }
    
    class func parseData(snapshot: QuerySnapshot?) -> [Thought] {
        var thoughts = [Thought]()
        guard let snap = snapshot else { return thoughts }
        for document in snap.documents {
            let data = document.data()
            let username = data[USERNAME] as? String ?? "Anonymous"
            let timestamp = data[TIMESTAMP] as? Timestamp ?? Timestamp()
            let thoughtTxt = data[THOUGHT_TXT] as? String ?? ""
            let numLikes = data[NUM_LIKES] as? Int ?? 0
            let numComments = data[NUM_COMS] as? Int ?? 0
            let docId = document.documentID
            let date = timestamp.dateValue()
            
            let newThought = Thought(username: username, timestamp: date, thoughtTxt: thoughtTxt, numLikes: numLikes, numComments: numComments, docId: docId)
            thoughts.append(newThought)
        }
        
        return thoughts
    }
}
