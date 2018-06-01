//
//  CoreDataManager.swift
//  CoreDataNewTry
//
//  Created by Tianyuan Zhang on 2018/5/11.
//  Copyright © 2018年 qwe. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject, CoreDataProtocol {
    func getTask(jobID: String, taskID: String) -> Task {
        <#code#>
    }
    
    func getTasks(jobID: String) -> [Task] {
        <#code#>
    }
    
    func getJob(jobID: String) -> Job {
        <#code#>
    }
    
    func getJobs() -> [Job] {
        <#code#>
    }
    
    func setTaskText(taskID: String, text: String) {
        <#code#>
    }
    
    func setTaskVideo(taskID: String, video: String) {
        <#code#>
    }
    
    func setTaskAudio(taskID: String, audio: String) {
        <#code#>
    }
    
    func setTaskPhoto(taskID: String, photo: UIImage) {
        <#code#>
    }
    
    func jobDisable(disable: Bool) {
        <#code#>
    }
    
    func taskDisable(disable: Bool) {
        <#code#>
    }
    
    func taskTextDisable(disable: Bool) {
        <#code#>
    }
    
    func taskAudioDisable(disable: Bool) {
        <#code#>
    }
    
    func taskVideoDisable(disable: Bool) {
        <#code#>
    }
    
    func taskPhotoDisable(disable: Bool) {
        <#code#>
    }
    
    func createJob(title: String) -> Job {
        <#code#>
    }
    
    func createTask(job: Job, title: String) -> Task {
        <#code#>
    }
    
    func deleteJob(jobID: String) {
        <#code#>
    }
    
    func deleteTask(jobID: String, taskID: String) {
        <#code#>
    }
    
    func createTestData() -> [Job] {
        <#code#>
    }
    
    
    
    
    
    static let database = CoreDataManager()
    lazy var context: NSManagedObjectContext = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        return context
    }()
    
    let fileSystemManager: FileSystemManager = FileSystemManager.fileSystemManager
    
    func setJob(id: String, name: String){
        let job = Job(context: context)
        job.id = id
        job.title = name
        saveData()
        print("Job is Saved!")
    }
    
    func getJob(id: String) -> (Job?){
        let fetchRequest: NSFetchRequest = Job.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do{
            let results: [Job] = try context.fetch(fetchRequest)
            if results.count == 0 {
                return nil
            }
            else {
                return results[0]
            }
        }
        catch{
            fatalError("Retrieve failed")
        }
    }
    
    func getAllJobs() -> [Job] {
        let fetchRequest: NSFetchRequest = Job.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            return result            }
        catch {
            fatalError();
        }
    }
    
    func deletAllJobs(){
        for job in getAllJobs() {
            deleteAllTasks(job: job)
            context.delete(job)
        }
        saveData()
        print("All jobs were deleted")
    }
    
    func setTask(job: Job, name: String, id: String, jobid: String){
        let task = Task(context: context)
        task.title = name
        task.id = id
        task.jobid = jobid
        task.photo = "\(task.jobid! + task.id!).jpg"
        task.video = "\(task.jobid! + task.id!).mp4"
        task.audio = "\(task.jobid! + task.id!).m4a"
        task.disableTask = false
        task.disableText = true
        task.disableAudio = true
        task.disablePhoto = true
        task.disableVideo = true
//        fileSystemManager.saveImage(task: task, image: UIImage(contentsOfFile: "/Users/TianyuanZhang/Desktop/imageDemo.jpg")!, quality: 1.0, nameWithExtension: "\(task.jobid! + task.id!).jpg")
//        fileSystemManager.saveVideo(task: task, videoFromURLString: "/Users/TianyuanZhang/Downloads/Wildlife.mp4", nameWithExtension: "\(task.jobid! + task.id!).mp4")
        job.addToHas(task)
        saveData()
        print("Task Saved!")
    }
    
    func getTask(job: Job, id: String)->(Task?){
        //        let fetchRequest: NSFetchRequest = Task.fetchRequest()
        //        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        //        do{
        //            let results: [Task] = try context.fetch(fetchRequest)
        //            if results.count == 0 {
        //                return nil
        //            }
        //            else {
        //                return results[0]
        //            }
        //        }
        //        catch{
        //            fatalError("Retrieve failed")
        //        }
        for task in job.has?.array as! [Task]{
            if task.id! == id{
                return task
            }
        }
        return nil
    }
    
    func getAllTask(job: Job) -> [Task] {
        //        let fetchRequest: NSFetchRequest = Task.fetchRequest()
        //        do {
        //            let result = try context.fetch(fetchRequest)
        //            return result
        //        } catch {
        //            fatalError();
        //        }
        return job.has?.array as! [Task]
    }
    
    func deleteAllTasks(job: Job){
        for task in getAllTask(job: job){
            let photoURLString = NSHomeDirectory() + "/Documents/Images/" + task.photo!
            let videoURLString = NSHomeDirectory() + "/Documents/Videos/" + task.video!
            let audioURLString = NSHomeDirectory() + "/Documents/Audios/" + task.audio!
            context.delete(task)
            fileSystemManager.deletImage(URLString: photoURLString)
            fileSystemManager.deletVideo(URLString: videoURLString)
            fileSystemManager.deletAudio(URLString: audioURLString)
        }
        saveData()
        print("All Tasks were deleted")
    }
    
    func saveData(){
        do{
            try context.save()
        }
        catch{
            fatalError()
        }
    }
    
    // functions for coredata interface
    func getJobID() -> Int {
        let jobs: [Job] = getAllJobs()
        let lastID = Int((jobs.last?.id)!)
        return lastID! + 1
    }
    
    func getTaskID(job: Job) -> Int {
        let tasks: [Task] = getAllTask(job: job)
        let lastID = Int((tasks.last?.id)!)
        return lastID! + 1
    }
    
    func setTaskText(jobID: String, taskID: String, text: String) {
        let task = getTask(job: getJob(id: jobID)!, id: taskID)
        task?.text = text
        task?.disableText = false
        saveData()
        print("Task text was set")
    }
    
    func setTaskImage(jobID: String, taskID: String, image: UIImage) {
        let task = getTask(job: getJob(id: jobID)!, id: taskID)!
        fileSystemManager.deletImage(URLString: NSHomeDirectory() + "/Documents/Images/" + task.photo!)
        fileSystemManager.saveImage(task: task, image: image, quality: 1.0, nameWithExtension: task.photo!)
        task.disablePhoto = false
        saveData()
        print("Task image was set")
    }
    
    func setTaskVideo(jobID: String, taskID: String, videoURLString: String) {
        let task = getTask(job: getJob(id: jobID)!, id: taskID)!
        fileSystemManager.deletVideo(URLString: NSHomeDirectory() + "/Documents/Videos/" + task.video!)
        fileSystemManager.saveVideo(task: task, videoFromURLString: videoURLString, nameWithExtension: task.video!)
        task.disableVideo = false
        saveData()
        print("Task video was set")
    }
    
    func setTaskAudio(jobID: String, taskID: String, audioURLString: String) {
        let task = getTask(job: getJob(id: jobID)!, id: taskID)!
        fileSystemManager.deletAudio(URLString: NSHomeDirectory() + "/Documents/Audios/" + task.audio!)
        fileSystemManager.saveAudio(task: task, audioFromURLString: audioURLString, nameWithExtension: task.audio!)
        task.disableAudio = false
        saveData()
        print("Task audio was set")
    }
    
    func saveAnalytics(job: Job, task: Task, date: Date, duration: TimeInterval){
        task.analytics = Analytics(dat: date, dur: duration)
        saveData()
        print("Task analytics were saved")
    }
}
