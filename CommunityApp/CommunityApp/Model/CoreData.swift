//
//  CoreData.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-10.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

final class CoreData {
    
    // I will need functions to
    //Create, Retrieve, Update, and Delete
    // single Jobs
    // multiple Jobs
    // single Tasks
    // multiple Tasks
    // AnalyticData
    // I would like all of these functions to be static
    private init() { }
    
    
    //static func getJobs() -> [Job] {
    //   return Job.tempJobs()
    //}
    
    static var tempJob: [Job] = Job.tempJobs()
    
    
    
    
    
    // static func getJob(jobID: Int) -> Job { }
    // static func getTasks(jobID: Int) -> Task { }
    // static func getTask(jobID: Int, taskID: Int) -> Task { }
    static func getJobID() -> Int { return 0 }
    static func getTaskID() -> Int {return 1}
    
    
    static func setJob(job: Job) {
    
    }
    static func setTask(jobID: Int, task: Task) {
        
    }
    // CRUD
    // create retrive Update Delete
    
    static func setTaskText(jobID: Int, taskID: Int, text: String) -> Bool{
        return true
    }
    
    
    
    
    // static func getAnalytics() -> [AnalyticData] { }
    // static func getAnalytics(job: Job) -> [AnalyticData] { }
    // static func getAnalytics(job: Job, taskNumber: Int) -> [AnalyticData] { }
    // static func getAnalytics(job: Job, task: Task) -> [AnalyticData] {}
    
    /*
    private static func formatAnalyticData(analytics: [AnalyticData]) {
        // Organize by Jobs
        // Organize by Tasks
        // Organize by Analytics
    }
    
    static func analyticDataToJSON(analyticData: [AnalyticData]) -> String {
        var json: String!
        let jsonEncoder = JSONEncoder()
        
        for analytics in analyticData {
            // let jsonData = try jsonEncoder.encode(analytics)
            // json.append(String(data: jsonData, encoding: String.Encoding.utf16)!)
        }
        return json
    }
    
    
    static func saveAnalytics(job: Job, task: Task) {
        // Save Analytic Data to a specific job and a specific task
    }
    */

}
