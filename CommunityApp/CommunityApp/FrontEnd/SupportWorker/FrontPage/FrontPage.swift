//
//  FrontPage.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-12.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class FrontPage: UIViewController {
    
    
    @IBOutlet weak var supportWorker: UIButton!
    
    var jobCount: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.database.fileSystemManager.createImageFolder()
        CoreDataManager.database.fileSystemManager.createVideoFolder()
        CoreDataManager.database.fileSystemManager.createAudioFolder()
        for job in CoreDataManager.database.getAllJobs() {
            for task in CoreDataManager.database.getAllTask(job: job) {
                CoreDataManager.database.deleteUnfinishedAnalytics(task: task)
            }
        }
        // CoreDataManager.database.deletAllJobs()
        self.navigationItem.title = "Front Page"
        supportWorker.addTarget(self, action: #selector(FrontPage.toSignIn(_:event:)), for: UIControlEvents.touchDownRepeat)
       
       // supportWorker.addTarget(self, action: #selector(multipleTap(_:event:)), for: UIControlEvents.touchDownRepeat)
    }
    
    
    
    /*override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let database = CoreDataManager.database
        let fileSystemManager = database.fileSystemManager
       fileSystemManager.createImageFolder()
        fileSystemManager.createVideoFolder()
        fileSystemManager.createAudioFolder()
        for job in database.getAllJobs() {
            for task in database.getAllTask(job: job) {
                database.deleteUnfinishedAnalytics(task: task)
            }
        }
    }*/
    
  
    
    @objc func toSignIn(_ sender: UIButton, event: UIEvent) {
        let touch: UITouch = event.allTouches!.first!
        if (touch.tapCount == 2) {
            performSegue(withIdentifier: Constant.segueID.SignIn, sender: self)
        } else {
            print("the taps were not two")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        jobCount = CoreDataManager.database.getJobs(include: false).count
    }
    
    @IBAction func userLogin(_ sender: Any) {
        
        if jobCount == 0 {
            performSegue(withIdentifier:Constant.segueID.SignIn , sender: self)
        } else {
            performSegue(withIdentifier: Constant.segueID.JobSelector, sender: self)
        }
    }
}

// Put this piece of code anywhere you like
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
    }
}
