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
    static let segueID = "toFrontPage"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreDataManager.database.fileSystemManager.createImageFolder()
        CoreDataManager.database.fileSystemManager.createVideoFolder()
        CoreDataManager.database.fileSystemManager.createAudioFolder()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
