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
    
    @IBOutlet weak var signInButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered Sign IN")
        signInButton.addTarget(self, action: #selector(SignIn.signIn), for: .touchUpInside)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func signIn() {
        performSegue(withIdentifier: JobManager.segueID, sender: self)
    }
    
}
