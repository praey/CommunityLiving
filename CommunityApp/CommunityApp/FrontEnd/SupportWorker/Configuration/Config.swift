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
    
   // @IBOutlet weak var username: UITextField!
    @IBOutlet weak var personName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var boxView: UIView!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer.contents = UIImage(named:"background")?.cgImage
        
        boxView.layer.cornerRadius = 9
        boxView.layer.shadowOffset = CGSize(width: 5, height: 5)
        boxView.layer.shadowOpacity = 0.7
        boxView.layer.shadowRadius = 5
        boxView.layer.shadowColor = UIColor(red: 44.0/255.0, green: 62.0/255.0, blue: 80.0/255.0, alpha: 1.0).cgColor
        
        deleteButton.layer.cornerRadius = 16
        
        self.hideKeyboardWhenTappedAround()
        //username.text = Constant.getUsername()
        password.text = Constant.getPassword()
        
        personName.text = Constant.getPersonName()
        self.navigationItem.title = "Configuation"
        
    }
    
    
    
    @IBAction func deleteAllJobs(_ sender: Any) {
        
        let alert = UIAlertController(title: "WARNING!", message: "THIS ACTION WILL DELETE ALL JOBS", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: deleteJobs))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        
        
    }
    
    func deleteJobs(alert: UIAlertAction) {
        CoreDataManager.database.deletAllJobs()
    }
    override func viewDidDisappear(_ animated: Bool) {
        //Constant.setUsername(username.text!)
        Constant.setPassword(password.text!)
        Constant.setPersonName(personName.text!)
    }
}
