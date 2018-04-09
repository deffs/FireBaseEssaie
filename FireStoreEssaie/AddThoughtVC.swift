//
//  AddThoughtVCViewController.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/9/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit

class AddThoughtVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var catSegment: UISegmentedControl!
    
    @IBOutlet weak var userNameBox: UITextField!
    @IBOutlet weak var thoughtTxt: UITextView!
    @IBOutlet weak var postBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let font = UIFont(name: "AvenirNext-Regular", size: 16.0)
        catSegment.setTitleTextAttributes([NSAttributedStringKey.font: font!], for: .normal)
        thoughtTxt.layer.cornerRadius = 4.0
        postBtn.layer.cornerRadius = 4.0
        thoughtTxt.text = "My random thought..."
        thoughtTxt.textColor = UIColor.lightGray
        thoughtTxt.delegate = self
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.darkGray
    }
    
    @IBAction func catChanged(_ sender: Any) {
    }
    
    @IBAction func postTap(_ sender: Any) {
    }
    


}
