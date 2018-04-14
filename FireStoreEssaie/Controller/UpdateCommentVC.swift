//
//  UpdateCommentVC.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/14/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit
import Firebase

class UpdateCommentVC: UIViewController {

    @IBOutlet weak var commentTxt: UITextView!
    @IBOutlet weak var updateBtn: UIButton!
    
    var commentData: (comment: Comment, thought: Thought)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        commentTxt.layer.cornerRadius = 8.0
        updateBtn.layer.cornerRadius = 8.0
        commentTxt.text = commentData.comment.commentTxt
    }

    
    
    @IBAction func updateTap(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).document(commentData.thought.docId).collection(COM_REF).document(commentData.comment.docId).updateData([COM_TXT : commentTxt.text]) { (error) in
            if let error = error {
                debugPrint("Unable to update \(error)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
}
