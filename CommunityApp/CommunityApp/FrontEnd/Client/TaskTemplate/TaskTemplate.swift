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
    var isTest: Bool = false
    var timer: Timer!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        taskDescription = getDescription()
        if !isTest {
        CoreDataManager.database.startAnalytics(task: task)
        }
        timer = Timer.scheduledTimer(timeInterval: 6, target: self, selector: #selector(timerSelector), userInfo: nil, repeats: false)
    }
    
    @objc func timerSelector() {
        CoreDataManager.database.deleteUnfinishedAnalytics(task: task)
        self.navigationController?.popToViewController(task.getViewController(withIdentifier: Constant.segueID.JobSelector), animated: true)
    }
    
    func isTest(_ testing: Bool) {
        isTest = testing
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
        if !isTest {
            CoreDataManager.database.saveAnalytics(task: task, desc: taskDescription )
        }
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    func setTask(task: Task) {
        self.task = task
    }


}




