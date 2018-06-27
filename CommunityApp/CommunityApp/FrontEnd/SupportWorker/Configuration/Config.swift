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
    let defaults = UserDefaults.standard
    
    enum keyValue {
        static let username = "username"
        static let password = "password"
        static let email = "email"
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        username.text = getName()
        password.text = getPassword()
        email.text = getEmail()
    }
    
    func validateLogin(username: String, password: String) -> Bool {
        if username == getName() && password == getPassword() {
            return true
        }
        return false
    }
    
    
    func getPassword() -> String {
        return defaults.string(forKey: keyValue.password) ?? "defaultPassword"
    }
    
    func getName() -> String {
        return defaults.string(forKey: keyValue.username) ?? "defaultUserName"
    }
    
    func getEmail() -> String {
        return defaults.string(forKey: keyValue.email) ?? "defaultEmail"
    }
    
    @IBAction func deleteAllJobs(_ sender: Any) {
          CoreDataManager.database.deletAllJobs()
    }
    override func viewWillDisappear(_ animated: Bool) {
        defaults.set(username.text, forKey: keyValue.username)
        defaults.set(password.text, forKey: keyValue.password)
        defaults.set(email.text, forKey: keyValue.email)
    }
}
