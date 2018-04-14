//
//  CommentsVC.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/13/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit
import Firebase

class CommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addComment: UIButton!
    @IBOutlet weak var commentBox: UITextField!
    
    var thought: Thought!
    var comments = [Comment]()
    var thoughtRef: DocumentReference!
    let firestore = Firestore.firestore()
    var username: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        commentBox.layer.cornerRadius = 8.0
        commentBox.setLeftPaddingPoints(10)
        commentBox.attributedPlaceholder = NSAttributedString(string: "Add Comment...",
                                                            attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)])
        
        thoughtRef = firestore.collection(THOUGHTS_REF).document(thought.docId)
        if let name = Auth.auth().currentUser?.displayName {
            username = name
        }
    }
    
    @IBAction func addComment(_ sender: Any) {
        guard let commentTxt = commentBox.text else { return }
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        cell.configureCell(comment: comments[indexPath.row])
        return cell
    }


}
