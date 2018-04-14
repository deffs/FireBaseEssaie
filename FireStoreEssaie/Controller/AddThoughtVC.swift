//
//  AddThoughtVCViewController.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/9/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit
import Firebase

class AddThoughtVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet private weak var catSegment: UISegmentedControl!
    @IBOutlet private weak var userNameBox: UITextField!
    @IBOutlet private weak var thoughtTxt: UITextView!
    @IBOutlet private weak var postBtn: UIButton!
    
    private var selectedCategory = ThoughtCategory.funny.rawValue
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let font = UIFont(name: "AvenirNext-Medium", size: 17.0)
        catSegment.setTitleTextAttributes([NSAttributedStringKey.font: font!], for: .normal)
        postBtn.layer.cornerRadius = 4.0
        thoughtTxt.layer.cornerRadius = 4.0
        thoughtTxt.text = "My random thought..."
        thoughtTxt.textColor = UIColor.white
        thoughtTxt.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        textView.textColor = UIColor.white
    }
    
    @IBAction func catChanged(_ sender: Any) {
        switch catSegment.selectedSegmentIndex {
        case 0:
            selectedCategory = ThoughtCategory.funny.rawValue
        case 1:
            selectedCategory = ThoughtCategory.serious.rawValue
        default:
            selectedCategory = ThoughtCategory.crazy.rawValue
        }
    }
    
    @IBAction func postTap(_ sender: Any) {
        Firestore.firestore().collection(THOUGHTS_REF).addDocument(data: [
            CAT : selectedCategory,
            NUM_COMS : 0,
            NUM_LIKES : 0,
            THOUGHT_TXT : thoughtTxt.text,
            TIMESTAMP : FieldValue.serverTimestamp(),
            USERNAME : userNameBox.text!,
            USER_ID : Auth.auth().currentUser?.uid ?? ""
        ]) { (err) in
            if let err = err {
                debugPrint("Error adding doc: \(err)")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    
}
