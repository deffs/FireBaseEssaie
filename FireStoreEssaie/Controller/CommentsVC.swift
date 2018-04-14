//
//  CommentsVC.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/13/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit
import Firebase

class CommentsVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CommentDelegate {
    func cOptionsTapped(comment: Comment) {
        print(comment.username)
    }
    
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addComment: UIButton!
    @IBOutlet weak var commentBox: UITextField!
    
    var thought: Thought!
    var comments = [Comment]()
    var thoughtRef: DocumentReference!
    let firestore = Firestore.firestore()
    var username: String!
    var commentListener: ListenerRegistration!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 80.0
        tableView.rowHeight = UITableViewAutomaticDimension
        commentBox.layer.cornerRadius = 8.0
        commentBox.setLeftPaddingPoints(10)
        commentBox.attributedPlaceholder = NSAttributedString(string: "Add Comment...",
                                                            attributes: [NSAttributedStringKey.foregroundColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)])
        
        thoughtRef = firestore.collection(THOUGHTS_REF).document(thought.docId)
        if let name = Auth.auth().currentUser?.displayName {
            username = name
        }
        self.view.bindToKeyboard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        commentListener = firestore.collection(THOUGHTS_REF).document(self.thought.docId)
            .collection(COM_REF)
            .order(by: TIMESTAMP, descending: false)
            .addSnapshotListener({ (snapshot, error) in
                guard let snapshot = snapshot else {
                    debugPrint("Error fetching comments :\(error!)")
                    return
                }
                self.comments.removeAll()
                self.comments = Comment.parseData(snapshot: snapshot)
                self.tableView.reloadData()
            })
    }
    
    @IBAction func addComment(_ sender: Any) {
        guard let commentTxt = commentBox.text else { return }
        if commentBox.text == "" { return }
        firestore.runTransaction({ (transaction, error) -> Any? in
            let thoughtDoc: DocumentSnapshot
            
            do {
                try thoughtDoc = transaction.getDocument(self.firestore.collection(THOUGHTS_REF).document(self.thought.docId))
            } catch let error as NSError {
                debugPrint("Fetch error: \(error.localizedDescription)")
                return nil
            }
            guard let oldNumComments = thoughtDoc.data()![NUM_COMS] as? Int else {
                return nil
            }
            transaction.updateData([NUM_COMS : oldNumComments + 1], forDocument: self.thoughtRef)
            let newCommentRef = self.firestore.collection(THOUGHTS_REF).document(self.thought.docId)
                .collection(COM_REF).document()
            
            transaction.setData([
                COM_TXT : commentTxt,
                TIMESTAMP : FieldValue.serverTimestamp(),
                USERNAME : self.username,
                USER_ID : Auth.auth().currentUser?.uid ?? ""
                ], forDocument: newCommentRef)
            
            return nil
        }) { (object, error) in
            if let error = error {
                debugPrint("Tx failed: \(error)")
            } else {
                self.commentBox.text = ""
                self.commentBox.resignFirstResponder()
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        cell.configureCell(comment: comments[indexPath.row], delegate: self)
        return cell
    }


}
