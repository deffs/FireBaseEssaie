//
//  ThoughtCell.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/10/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit
import Firebase

class ThoughtCell: UITableViewCell {

    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var numLikesLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    private var thought: Thought!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImg.image = likeImg.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        likeImg.tintColor = #colorLiteral(red: 0.1803921569, green: 0.4901960784, blue: 0.1960784314, alpha: 1)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(likeTapped))
        likeImg.addGestureRecognizer(tap)
        likeImg.isUserInteractionEnabled = true
    }
    
    @objc func likeTapped() {
        //Firestore.firestore().collection(THOUGHTS_REF).document(thought.docId)
         //   .setData([NUM_LIKES : thought.numLikes + 1], options: SetOptions.merge())
        Firestore.firestore().document("thoughts/\(thought.docId!)")
            .updateData([NUM_LIKES : thought.numLikes + 1])
    }

    func configureCell(thought: Thought) {
        self.thought = thought
        usernameLbl.text = thought.username
        thoughtTxtLbl.text = thought.thoughtTxt
        numLikesLbl.text = String(thought.numLikes)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        let timestamp = formatter.string(from: thought.timestamp)
        timestampLbl.text = timestamp
    }

}
