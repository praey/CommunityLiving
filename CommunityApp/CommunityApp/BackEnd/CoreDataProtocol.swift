//
//  CoreDataProtocol.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-26.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

protocol CoreDataProtocol {
    // MARK: Get function
    func getTask(jobID: String, taskID: String) -> Task
    func getTasks(jobID: String) -> [Task]
    func getJob(jobID: String) -> Job
    func getJobs() -> [Job]
   
    // MARK: Set function
    func setTaskText(jobID: String, taskID: String, text: String)
    func setTaskVideo(jobID: String, taskID: String, videoURLString: String)
    func setTaskAudio(jobID: String, taskID: String, audioURLString: String)
    func setTaskPhoto(jobID: String, taskID: String, photo: UIImage)
    
    
    // MARK: File exists functions
    // func ifFileExists(filePath: String) -> Bool
    // func audioFileExists(task: Task) -> Bool
    // func videoFileExists(task: Task) -> Bool
    // func imageFileExists(task: Task) -> Bool
    
    
    // MARK: Create function
    func createJob(title: String) -> Job
    func createTask(job: Job) -> Task
    // func createTask(job: Job, title: String) -> Task
    
    // MARK: Delete function
    func deleteJob(jobID: String)
    func deleteTask(task: Task)
 
//    // MARK: Testing function
//    func createTestData() -> [Job]
    
    
    // MARK: Save function - These are the update functions
    // func saveJob(job: Job) -> Bool
    // func saveTask(task: Task) -> Bool

}
