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
        static var Finger: Disable       { return self.init(rawValue: 1 << 4)}
        static var Stylus: Disable       { return self.init(rawValue: 1 << 5)}
    }
    
    struct TaskType: OptionSet, Codable {
        // Mark: Properties
        let rawValue: Int
        
        static var Emtpy: TaskType = []
        static var Text: TaskType { return self.init(rawValue: 0 )}
        static var Photo: TaskType  { return self.init(rawValue: 1 << 0)}
        static var Audio: TaskType      { return self.init(rawValue: 1 << 1)}
        static var Video: TaskType    { return self.init(rawValue: 1 << 2)}
    }

    

    private let ID: Int!
    let job: Job!
    var title: String!
    var taskType: TaskType = TaskType.Emtpy
    var isDisabled: Disable = Disable.Empty
    
    var startTime: Date!
    var duration: TimeInterval!
    
    
    // This should point to the location of the File
    var text: String? = nil
    //var audio: Data? = nil
    //var video: Data? = nil
    var photo: URL? = nil
    
    // I need to be able to set flags for 4 things - 5
    
    init(job: Job) {
        self.ID = CoreData.getTaskID()
        self.job = job
    }

    init(job: Job, title: String, text: String) {
        self.ID = CoreData.getTaskID()
        self.job = job
        self.title = title
        self.text = text
        self.taskType.formUnion(.Text)
    }
    
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
        /*do {
            let data: Data = try Data.init(contentsOf: self.photo!)
            let image = UIImage.init(data: data)!
            return image
        } catch let error as? Error {
            return UIImage.init(named: "errorImage")!
        }*/
        return UIImage.init(named: "errorImage")!
    }
    
    func setDisabled() {
        
    }
    
    func getText() -> String {
        return text!
    }

    func assign(task: Task) {
        self.title = task.title
        self.isDisabled = task.isDisabled
        
        self.text = task.text
        
    }
    func getJobID() -> Int {
        return self.job.getID()
    }
    
    func getID() -> Int {
        return self.ID
    }
    
    func startAnalytics() {
        startTime = Date()
    }
    
    // Analytic Data 
    func saveAnalytics() {
        duration = Date().timeIntervalSince(startTime)
        
        if format() {
            // CoreData.saveAnalytics(job: job.ID, task: self.ID)
        } else {
            //print("Job: \(jobID) Task: \(self.title) didn't follow proper format to be submitted to Database")
        }
    }

    private func format() -> Bool {
        // This is where we take out things that do not conform to the set rules that we have.
        return true
    }
    
}






