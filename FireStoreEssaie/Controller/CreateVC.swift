//
//  CreateVC.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/11/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit
import Firebase

class CreateVC: UIViewController {
    
    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var passBox: UITextField!
    @IBOutlet weak var userBox: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBtn.layer.cornerRadius = 10.0
        cancelBtn.layer.cornerRadius = 10.0
        emailBox.layer.cornerRadius = 8.0
        passBox.layer.cornerRadius = 8.0
        userBox.layer.cornerRadius = 8.0
        
        emailBox.attributedPlaceholder = NSAttributedString(string: "email",
                                                               attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)])
        passBox.attributedPlaceholder = NSAttributedString(string: "password",
                                                            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)])
        userBox.attributedPlaceholder = NSAttributedString(string: "public username",
                                                            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)])
        emailBox.setLeftPaddingPoints(10)
        passBox.setLeftPaddingPoints(10)
        userBox.setLeftPaddingPoints(10)
    }
    
    @IBAction func createTap(_ sender: Any) {
        
        guard let email = emailBox.text,
            let password = passBox.text,
            let username = userBox.text else { return }
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error creating user: \(error.localizedDescription)")
            }
            
            let changeRequest = user?.createProfileChangeRequest()
            changeRequest?.displayName = username
            changeRequest?.commitChanges(completion: { (error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
            })
            guard let userId = user?.uid else { return }
            Firestore.firestore().collection(USERS_REF).document(userId).setData([
                USERNAME : username,
                DATE_CREATED : FieldValue.serverTimestamp()
                ], completion: {(error) in
                    if let error = error {
                        debugPrint(error.localizedDescription)
                    } else {
                        self.dismiss(animated: true, completion: nil)
                    }
            })
        }
    }
    
    @IBAction func cancelTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

