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
    
    
    func getTask(row: Int) -> Task {
        let task = self.getTasks()[row]
        return task
    }


    func getTasks() -> [Task] {
        let tasks = self.has?.array as! [Task]
        return tasks
    }
    
    var thumbnail: UIImage? {
        get {
            for task in getTasks() {
                if let smallPhoto =  task.thumbnail {
                    return smallPhoto
                }
            }
            return nil
        }
    }
    
    var notificationRequests: [UNNotificationRequest]? {
        get {
            var notificationRequest: [UNNotificationRequest]?
            UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests in
                notificationRequest = requests
            })
            if let requests = notificationRequest {
                notificationRequest = requests.filter {$0.identifier == self.id!}
            }
            return notificationRequest
        }
    }
    
}
