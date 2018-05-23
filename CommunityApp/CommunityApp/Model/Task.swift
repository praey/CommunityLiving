//
//  Task.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit


class Task: Codable {
    
    
    
    struct Disable: OptionSet, Codable{
        // Mark: Properties
        let rawValue: Int
        
        static var Empty: Disable = []
        static var Task: Disable     { return self.init(rawValue: 0 )}
        static var Text: Disable    { return self.init(rawValue: 1 << 0)}
        static var Photo: Disable  { return self.init(rawValue: 1 << 1)}
        static var Audio: Disable      { return self.init(rawValue: 1 << 2)}
        static var Video: Disable    { return self.init(rawValue: 1 << 3)}
    }
    
    struct TaskType: OptionSet, Codable {
        // Mark: Properties
        let rawValue: Int
        
        static var Empty: TaskType = []
        static var Text: TaskType { return self.init(rawValue: 0 )}
        static var Photo: TaskType  { return self.init(rawValue: 1 << 0)}
        static var Audio: TaskType      { return self.init(rawValue: 1 << 1)}
        static var Video: TaskType    { return self.init(rawValue: 1 << 2)}
    }

    // MARK: Job Properties
    let job: Job!
    let ID: Int!
    private(set) var title: String!
    
    var taskType: TaskType = TaskType.Empty
    var isDisabled: Disable = Disable.Empty
    
    private(set) var text: String?
    private(set) var audio: URL?
    private(set) var video: URL?
    private(set) var photo: URL?
    
    // Analytic Data
    // private var analyticData: Dictionary = [Date():TimeInterval]
    
    private var startTime: Date!
    private var duration: TimeInterval!
    
    init(job: Job) {
        self.ID = CoreData.getTaskID()
        self.job = job
        self.job.addTask(newTask: self)
    }

    init(job: Job, title: String, text: String) {
        self.ID = CoreData.getTaskID()
        self.job = job
        self.job.addTask(newTask: self)
        self.title = title
        self.text = text
        self.taskType.formUnion(.Text)
    }
    
    
    // MARK: Get Functions
    
    func getTaskType() -> [String] {
        var content: [String] = []
        
        if(taskType.contains(.Text)) {
            content.append("Text")
        }
        if(taskType.contains(.Photo)) {
            content.append("Photo")
        }
        if(taskType.contains(.Audio)) {
            content.append("Audio")
        }
        if(taskType.contains(.Video)){
            content.append("Video")
        }
        
        return content
    }
   
    func getPhoto() -> UIImage {
        //let image = UIImage.init(
        //self.photo ?? UIImage.init(named: "errorImage")!
        //let image = UIImage.init(data: Data.init(contentsOf: self.photo!))
        /*do {
            let data: Data = try Data.init(contentsOf: self.photo!)
            let image = UIImage.init(data: data)!
            return image
        } catch let error as? Error {
            return UIImage.init(named: "errorImage")!
        }*/
        let image = UIImage.init(named: "errorImage")!
        return image
    }
    
    func getText() -> String {
        let word = self.text ?? "default text"
        return word
    }
 
    func getJobID() -> Int {
        return self.job.getID()
    }
    
    func getID() -> Int {
        return self.ID
    }
    
    // MARK: Set Functions
    
    func setDisabled(taskType: TaskType) {
        self.taskType.formUnion(taskType)
        // Will need to inform database that this is not disabled
    }

  
    
    func setText(text: String) {
        CoreData.setTaskText(jobID: job.getID(), taskID: self.ID, text: text)
        self.text = text
    }
    
    // MARK: Analytics
    func startAnalytics() {
        startTime = Date()
    }
    
    func saveAnalytics() {
        let date = Date()
        duration = date.timeIntervalSince(startTime)
        
        
        if format(timeInterval: duration) {
            //CoreData.saveAnalytics(job: job, task: self.ID, date: date, duration: duration)
        } else {
            print("Job: \(job.getID()) Task: \(self.title) didn't follow proper format to be submitted to Database")
        }
    }

    private func format(timeInterval: TimeInterval) -> Bool {
        if timeInterval < 300 {
            print("Success: Format Time interval was under 300")
            return true
        } else {
            print("Failure: Format Time interval was over 300")
            return false
        }
    }
    
}








