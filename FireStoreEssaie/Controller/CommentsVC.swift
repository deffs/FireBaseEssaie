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
        tableView.rowHeight = UITableView.automaticDimension
        commentBox.layer.cornerRadius = 8.0
        commentBox.setLeftPaddingPoints(10)
        commentBox.attributedPlaceholder = NSAttributedString(string: "Add Comment...",
                                                            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)])
        
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
    
    override func viewDidDisappear(_ animated: Bool) {
        commentListener.remove()
    }
    
    func cOptionsTapped(comment: Comment) {
        let alert = UIAlertController(title: "Edit Comment", message: "Delete or Edit Comments", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete Comment", style: .default) { (action) in
            self.firestore.runTransaction({ (transaction, error) -> Any? in
                
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
                transaction.updateData([NUM_COMS : oldNumComments - 1], forDocument: self.thoughtRef)
                
                transaction.deleteDocument(self.firestore.collection(THOUGHTS_REF).document(self.thought.docId).collection(COM_REF).document(comment.docId))
                
                return nil
            }) { (object, error) in
                if let error = error {
                    debugPrint("Tx failed: \(error)")
                } else {
                    alert.dismiss(animated: true, completion: nil)
                }
            }
        }
        let editAction = UIAlertAction(title: "Edit Comment", style: .default) { (action) in
            self.performSegue(withIdentifier: "updateCom", sender: (comment, self.thought))
            alert.dismiss(animated: true, completion: nil)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(editAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? UpdateCommentVC {
            if let commentData = sender as? (comment: Comment, thought: Thought) {
                destination.commentData = commentData
            }
        }
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

            guard let oldNumComments = thoughtDoc.data()![NUM_COMS] as? Int, let username = self.username else {
                debugPrint("username is nil")
                return nil
            }

            let newCommentRef = self.firestore.collection(THOUGHTS_REF).document(self.thought.docId)
                .collection(COM_REF).document()
            transaction.updateData([NUM_COMS : oldNumComments + 1], forDocument: self.thoughtRef)
            transaction.setData([
                COM_TXT : commentTxt,
                TIMESTAMP : FieldValue.serverTimestamp(),
                USERNAME : username,
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
        comments.count == 0 ? 1 : comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if comments.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
            let comment = Comment(username: "No Comments, Please Comment Below", timestamp: Date(), commentTxt: "", docId: "", userId: "")
            cell.configureCell(comment: comment, delegate: self)
            return cell
        }

        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentCell
        cell.configureCell(comment: comments[indexPath.row], delegate: self)
        return cell
    }


}
