//
//  CommentCell.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/13/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var commentTxt: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configureCell(comment: Comment) {
        usernameLbl.text = comment.username
        commentTxt.text = comment.commentTxt
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        let timestamp = formatter.string(from: comment.timestamp)
        timeLbl.text = timestamp
    }

}
