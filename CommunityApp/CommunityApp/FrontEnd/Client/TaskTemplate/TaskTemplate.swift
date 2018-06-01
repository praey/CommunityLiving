//
//  TaskTemplate.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class TaskTemplate: UIViewController {
   
    var task: Task!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.task.startAnalytics()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.task.saveAnalytics()
    }
    
    func setTask(task: Task) {
        self.task = task
    }


}

