//
//  Consts.swift
//  FireStoreEssaie
//
//  Created by Alex de France on 4/10/18.
//  Copyright © 2018 Def Labs. All rights reserved.
//
//<div>Icons made by <a href="http://www.freepik.com" title="Freepik">Freepik</a> from <a href="https://www.flaticon.com/" title="Flaticon">www.flaticon.com</a> is licensed by <a href="http://creativecommons.org/licenses/by/3.0/" title="Creative Commons BY 3.0" target="_blank">CC 3.0 BY</a></div>

import Foundation
import UIKit

let THOUGHTS_REF =  "thoughts"
let USERS_REF = "users"
let COM_REF = "comments"

let CAT = "category"
let NUM_COMS = "numComments"
let NUM_LIKES = "numLikes"
let THOUGHT_TXT = "thoughtTxt"
let TIMESTAMP = "timestamp"
let USERNAME = "username"
let DATE_CREATED = "dateCreated"
let COM_TXT = "commentTxt"
let USER_ID = "userId"


extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
