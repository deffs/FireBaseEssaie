//
//  CommentCell.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/13/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit
import Firebase

protocol CommentDelegate {
    func cOptionsTapped(comment: Comment)
}

class CommentCell: UITableViewCell {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var commentTxt: UILabel!
    @IBOutlet weak var optionsMenu: UIImageView!
    
    private var comment: Comment!
    private var delegate: CommentDelegate?

    func configureCell(comment: Comment, delegate: CommentDelegate?) {
        usernameLbl.text = comment.username
        commentTxt.text = comment.commentTxt
        optionsMenu.isHidden = true
        self.comment = comment
        self.delegate = delegate
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        let timestamp = formatter.string(from: comment.timestamp)
        timeLbl.text = timestamp
        
        if comment.userId == Auth.auth().currentUser?.uid {
            optionsMenu.isHidden = false
            optionsMenu.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(cOptionsTap))
            optionsMenu.addGestureRecognizer(tap)
        }
    }
    
    @objc func cOptionsTap() {
        delegate?.cOptionsTapped(comment: comment)
    }

}
