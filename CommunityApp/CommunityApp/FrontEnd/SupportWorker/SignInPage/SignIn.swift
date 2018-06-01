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
    
    
    @IBOutlet weak var nameValue: UITextField!
    
    @IBOutlet weak var emailValue: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered Sign IN")
        signInButton.addTarget(self, action: #selector(SignIn.signIn), for: .touchUpInside)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == JobManager.segueID {
            // if nameValue.text == Person.name && emailValue.text == Person.eamil {}
            return true
        }
        
        // Show text to the user about how they didn't enter in the right name and password
        return false
    }
    
    
    @objc func signIn() {
        performSegue(withIdentifier: JobManager.segueID, sender: self)
    }
    
}
