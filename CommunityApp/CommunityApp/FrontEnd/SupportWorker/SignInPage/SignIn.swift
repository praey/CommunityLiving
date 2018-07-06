//
//  SignIn.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-09.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class SignIn: UIViewController {
    
    var timer: Timer!
    
    @IBOutlet weak var nameValue: UITextField!
  
  
    @IBOutlet weak var passwordValue: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered Sign IN")
        signInButton.addTarget(self, action: #selector(SignIn.signIn), for: .touchUpInside)
//        nameValue.text = Constant.getUsername()
//        passwordValue.text = Constant.getPassword()
        
        timer = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(backToLastPage), userInfo: nil, repeats: false)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == Constant.segueID.JobManager {
            // if Config.validateLogin(username: self.nameValue.text!, password: self.passwordValue.text!) {
                return true
            
           
        }
        print("not to jobManager")
        // Show text to the user about how they didn't enter in the right name and password
        return false
    }
    
    
    @objc func signIn() {
        performSegue(withIdentifier: Constant.segueID.JobManager, sender: self)
    }
    
    @objc func backToLastPage() {
        if nameValue.text! == "" && passwordValue.text! == "" {
            navigationController?.popViewController(animated: true)
        }
    }
    
}
