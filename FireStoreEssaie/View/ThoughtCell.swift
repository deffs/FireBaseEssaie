//
//  ThoughtCell.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/10/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit

class ThoughtCell: UITableViewCell {

    
    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var timestampLbl: UILabel!
    @IBOutlet weak var thoughtTxtLbl: UILabel!
    @IBOutlet weak var numLikesLbl: UILabel!
    @IBOutlet weak var likeImg: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        likeImg.image = likeImg.image!.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        likeImg.tintColor = #colorLiteral(red: 0.1803921569, green: 0.4901960784, blue: 0.1960784314, alpha: 1)
    }

    func configureCell(thought: Thought) {
        usernameLbl.text = thought.username
        thoughtTxtLbl.text = thought.thoughtTxt
        numLikesLbl.text = String(thought.numLikes)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d, HH:mm"
        let timestamp = formatter.string(from: thought.timestamp)
        timestampLbl.text = timestamp
    }

}
