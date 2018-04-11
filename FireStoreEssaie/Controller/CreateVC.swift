//
//  CreateVC.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/11/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//

import UIKit

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
    }
   
    @IBAction func createTap(_ sender: Any) {
    }
    
    @IBAction func cancelTap(_ sender: Any) {
    }
}
