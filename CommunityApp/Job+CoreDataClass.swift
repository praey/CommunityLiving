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
import UIKit
import UserNotifications


public class Job: NSManagedObject {
    
    
    func getTask(row: Int, include disabled: Bool) -> Task {
        let task = self.getTasks(include: disabled)[row]
        return task
    }


    func getTasks(include disabled: Bool) -> [Task] {
        let tasks = CoreDataManager.database.getTasks(jobID: self.id!, include: disabled)
        return tasks
    }
    
    var thumbnail: UIImage? {
        get {
            for task in getTasks(include: true) {
                if let smallPhoto =  task.thumbnail {
                    return smallPhoto
                }
            }
            return nil
        }
    }
    
   
    
   
    
}
