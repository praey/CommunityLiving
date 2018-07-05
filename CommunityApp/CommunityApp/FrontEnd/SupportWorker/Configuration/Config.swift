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
  
 

    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = Constant.getUsername()
        password.text = Constant.getPassword()
        email.text = Constant.getEmail()
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
