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
    
 
    func getTask(row: Int) -> Task {
        return self.has!.allObjects[row] as! Task
    }
    
    func getTasks() -> [Task] {
        return self.has!.allObjects as! [Task]
    }
   
    
   /*
    static func tempJobs() -> [Job] {
        var jobs: [Job] = []
        for index in 0..<5 {
            let job: Job = Job(title: index.description)
            job.createTask(title: job.title, text: index.description)
            jobs.append(job)
        }
        return jobs
    }*/
    
}
 
 
