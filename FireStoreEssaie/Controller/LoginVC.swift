//
//  LoginVC.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/11/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var emailBox: UITextField!
    @IBOutlet weak var passBox: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createAccBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = 10.0
        createAccBtn.layer.cornerRadius = 10.0
    }

    @IBAction func loginTap(_ sender: Any) {
    }
    
    @IBAction func createTap(_ sender: Any) {
    }
    


}
