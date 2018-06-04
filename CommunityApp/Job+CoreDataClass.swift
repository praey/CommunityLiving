//
//  Job+CoreDataClass.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/5/30.
//  Copyright © 2018年 Javon Luke. All rights reserved.
//
//

import Foundation
import CoreData


public class Job: NSManagedObject {
    func getTask(row: Int) -> Task {
        let task = self.getTasks()[row]
        return task
    }


    func getTasks() -> [Task] {
        let tasks = self.has?.array as! [Task]
        return tasks
    }
}
