//
//  Job.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit
class Job {
    
    let title: String
    var tasks: [Task] = []
    
    init(title: String) {
        self.title = title
    }
    
    func createTask(title: String, text: String) {
        let task = Task.init(title: title, text: text)
        tasks.append(task)
    }
    
    static func tempJobs() -> [Job] {
        var jobs: [Job] = []
        for index in 0..<5 {
            var job: Job = Job(title: index.description)
            job.createTask(title: job.title, text: index.description)
            jobs.append(job)
        }
        return jobs
    }
    
    
    // This eventually needs to conform to accepting multiple Calendar dates.
    
    
}
