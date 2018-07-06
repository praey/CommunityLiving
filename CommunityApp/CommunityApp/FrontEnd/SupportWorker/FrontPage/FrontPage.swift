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
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.database.fileSystemManager.createImageFolder()
        CoreDataManager.database.fileSystemManager.createVideoFolder()
        CoreDataManager.database.fileSystemManager.createAudioFolder()
        // CoreDataManager.database.deletAllJobs()
        
        supportWorker.addTarget(self, action: #selector(FrontPage.toSignIn(_:event:)), for: UIControlEvents.touchDownRepeat)
        
       // supportWorker.addTarget(self, action: #selector(multipleTap(_:event:)), for: UIControlEvents.touchDownRepeat)
    }
    
    @objc func toSignIn(_ sender: UIButton, event: UIEvent) {
        let touch: UITouch = event.allTouches!.first!
        if (touch.tapCount == 2) {
            performSegue(withIdentifier: Constant.segueID.SignIn, sender: self)
        } else {
            print("the taps were not two")
        }
        
        
        
    }
    
    
}
