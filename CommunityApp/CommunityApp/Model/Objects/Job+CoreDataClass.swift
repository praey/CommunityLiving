//
//  Job+CoreDataClass.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/5/23.
//  Copyright © 2018年 Javon Luke. All rights reserved.
//
//

import Foundation
import CoreData


public class Job: NSManagedObject {
    
    init() {
        self.id = CoreData.getJobID()
        self.title = ""
    }
    
    init(title: String) {
        self.id = CoreData.getJobID()
        self.title = title
    }
    
    func createTask(title: String, text: String) {
        let task = Task.init(job: self, title: title, text: text)
        tasks.append(task)
    }
    
    func getID() -> Int {
        return self.id
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
}
 
 
