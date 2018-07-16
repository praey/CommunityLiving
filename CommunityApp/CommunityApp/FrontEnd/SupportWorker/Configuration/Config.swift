//
//  Config.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-09.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class Config: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var pageControllerSetting: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        username.text = Constant.getUsername()
        password.text = Constant.getPassword()
        var text = ""
        for email in Constant.getEmail()! {
            text += email + " "
        }
        email.text = text
    }
    
    
    
    @IBAction func deleteAllJobs(_ sender: Any) {
          CoreDataManager.database.deletAllJobs()
    }
    override func viewWillDisappear(_ animated: Bool) {
        Constant.setUsername(username.text!)
        Constant.setPassword(password.text!)
        Constant.setEmail(email.text!)
        
    }
}
