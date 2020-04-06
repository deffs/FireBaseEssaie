//
//  LoginVC.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/11/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var passBox: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createAccBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loginBtn.layer.cornerRadius = 8.0
        createAccBtn.layer.cornerRadius = 8.0
        emailBox.layer.cornerRadius = 8.0
        passBox.layer.cornerRadius = 8.0
        
        emailBox.attributedPlaceholder = NSAttributedString(string: "email",
                                                            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)])
        passBox.attributedPlaceholder = NSAttributedString(string: "password",
                                                            attributes: [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)])
        
        emailBox.setLeftPaddingPoints(10)
        passBox.setLeftPaddingPoints(10)
    }

    @IBAction func loginTap(_ sender: Any) {
        guard let email = emailBox.text,
            let password = passBox.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                debugPrint("Error signing in: \(error)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func createTap(_ sender: Any) {
        self.performSegue(withIdentifier: "create", sender: self)
        
    }
    


}
