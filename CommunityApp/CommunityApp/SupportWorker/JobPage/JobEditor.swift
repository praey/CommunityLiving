//
//  JobEditor.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-09.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class JobEditor: UIViewController {
    
    var job: Job?
    
    @IBOutlet weak var titleValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let validJob = job {
            // Set up the default Job
            titleValue.text = validJob.title
            
        } else {
            titleValue.text = "not valid"
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setJob(job: Job?) {
        self.job = job
    }
    
}
