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
    var taskDescription: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskDescription = getDescription()
        CoreDataManager.database.startAnalytics(task: task)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getDescription() -> String{
        
        var description: String = "TaskDescription:\n"
        
        if let title = task.title {
            description += "Title:,\(title)\n"
        }
        
        description += "Disabled,\(self.task.disableTask.description)\n"
    
        
        let taskType = task.getTaskType()
        var count = taskType.count
        if count > 0 {
            description += "TaskType:,"
            
            if taskType.contains(.audio) {
                description += "audio"
                count -= 1
                if count > 0 {
                    description += ","
                }
            }
            
            if taskType.contains(.video) {
                description += "video"
                count -= 1
                if count > 0 {
                    description += ","
                }
            }
            
            if taskType.contains(.photo) {
                description += "photo"
                count -= 1
                if count > 0 {
                    description += ","
                }
            }
            
            if taskType.contains(.text) {
                description += "text"
                count -= 1
                if count > 0 {
                    description += ","
                }
            }
            description += "\n"
        }
        
        
        return description
        
        
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       
        CoreDataManager.database.saveAnalytics(task: task, desc: taskDescription )
        
    }
    
    func setTask(task: Task) {
        self.task = task
    }


}




