//
//  Job.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit
import EventKit

class Job: Codable {

    let ID: Int!
    private(set) var title: String!
    private(set) var isDisabled: Bool!
    
    var tasks: [Task] = []
    var dates: [Calendar] = []// Calendar Objecr of recourring dates
    
    
    init() {
        self.ID = CoreData.getJobID()
        self.title = ""
    }

    init(title: String) {
        self.ID = CoreData.getJobID()
        self.title = title
    }

    func createTask(title: String, text: String) {
        let task = Task.init(job: self, title: title, text: text)
        tasks.append(task)
    }
    
    func getID() -> Int {
        return self.ID
    }
    
    func addTask(newTask: Task) {
        self.tasks.append(newTask)
    }

    // This eventually needs to conform to accepting multiple Calendar dates.
}

extension Job {
    
    func getJob(jobID: Int) -> Job {
        let job = CoreData.getJob(jobID: jobID)
        return job
    }
    

    static func tempJobs() -> [Job] {
        var jobs: [Job] = []
        for index in 0..<5 {
            let job: Job = Job(title: index.description)
            job.createTask(title: job.title, text: index.description)
            jobs.append(job)
        }
        return jobs
    }
}
