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
    
    static let database = CoreDataManager()
    
    lazy var context: NSManagedObjectContext = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        return context
    }()
    let fileSystemManager: FileSystemManager = FileSystemManager.fileSystemManager
    
    func getTask(jobID: String, taskID: String) -> Task {
        let job = getJob(id: jobID)!
        return getTask(job: job, id: taskID)!
    }
    
    func getTasks(jobID: String, include disabled: Bool) -> [Task] {
        let job = getJob(id: jobID)!
        if disabled {
            return getAllTask(job: job)
        } else {
           return getAllTask(job: job).filter {$0.disableTask == false}
            
        }
    }
    
    func getJob(jobID: String) -> Job {
        return getJob(id: jobID)!
    }
    
    func getJobs(include disabled: Bool) -> [Job] {
        let jobs = getAllJobs()
        if disabled {
            return jobs
        } else {
            let nonDisableJobs = jobs.filter {$0.disabelJob == false}
            let validJobs = nonDisableJobs.filter{$0.isValid()}
            return validJobs
        }
    }
    
    func createJob(title: String) -> Job {
        let id = getJobID()
        let job = Job(context: context)
        job.id = id
        job.title = title
        job.disabelJob = false
        saveData()
        print("Job is Saved!")
        return job
    }
    
    func createTask(job: Job) -> Task {
        let id = getTaskID(job: job)
        let task = Task(context: context)
        task.title = ""
        task.id = id
        task.photo = "\(job.id! + task.id!).jpg"
        task.video = "\(job.id! + task.id!).mp4"
        task.audio = "\(job.id! + task.id!).aac"
        task.disableTask = false
        task.disableText = true
        task.disableAudio = true
        task.disablePhoto = true
        task.disableVideo = true
        job.addToHas(task)
        saveData()
        print("Task Saved!")
        return task
    }
    
    func deleteJob(jobID: String) {
        let job = getJob(id: jobID)!
        deleteAllTasks(job: job)
        context.delete(job)
        saveData()
    }
    
    func deleteJob(job: Job) {
        deleteAllTasks(job: job)
        context.delete(job)
        saveData()
    }
    
    func deleteTask(task: Task) {
        let photoURLString = NSHomeDirectory() + "/Documents/Images/" + task.photo!
        let videoURLString = NSHomeDirectory() + "/Documents/Videos/" + task.video!
        let audioURLString = NSHomeDirectory() + "/Documents/Audios/" + task.audio!
        deleteAnalytics(task: task)
        context.delete(task)
        fileSystemManager.deletImage(URLString: photoURLString)
        fileSystemManager.deletVideo(URLString: videoURLString)
        fileSystemManager.deletAudio(URLString: audioURLString)
        saveData()
    }
    
    func deleteAnalytics(task: Task) {
        for analytics in (task.has?.array)! {
            context.delete(analytics as! Analytics)
        }
        saveData()
    }
    
    func deleteUnfinishedAnalytics(task: Task) {
        for analytics in (task.has?.array)! {
            if (analytics as! Analytics).duration == nil {
                context.delete(analytics as! Analytics)
            }
        }
        saveData()
    }
    
//    func createTestData() -> [Job] {
//        var jobs = [Job]()
//        let job = createJob(title: "test job 1")
//
//
//
//        let newTask = createTask(job: job)
//        // var path = Bundle.main.path(forResource: "audio.mp3", ofType: nil)!
//
//        // setTaskAudio(task: newTask, audioURLString: path)
//
//
//        var path = "/Users/newuser/Desktop/audio.mp3"
//        setTaskAudio(task: newTask, audioURLString: path)
//
//
//
//
//        let task = createTask(job: job)
//
//         path = "/Users/newuser/Desktop/testVideo.mp4"
//        // let url = URL.init(fileURLWithPath: path!)
//        setTaskVideo(task: task, videoURLString: path)
//
//
//
//
//
//        // path = "/Users/newuser/Desktop/testPhoto.jpg"
//        // setTaskPhoto(task: task, photo: UIImage.init(named: "testPhoto")!)
//        jobs.append(job)
//
//        return jobs
//    }
    
    
    
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
            return result
            
        }
        catch {
            
            fatalError()
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
    
    
    func getTask(job: Job, id: String)->(Task?){
        for task in job.has?.array as! [Task]{
            if task.id! == id{
                return task
            }
        }
        return nil
    }
    
    func getAllTask(job: Job) -> [Task] {
        return job.has?.array as! [Task]
    }
    
    func deleteAllTasks(job: Job){
        for task in getAllTask(job: job){
            let photoURLString = NSHomeDirectory() + "/Documents/Images/" + task.photo!
            let videoURLString = NSHomeDirectory() + "/Documents/Videos/" + task.video!
            let audioURLString = NSHomeDirectory() + "/Documents/Audios/" + task.audio!
            deleteAnalytics(task: task)
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
    func getJobID() -> String {
        let jobs: [Job] = getAllJobs()
        if let job = jobs.last {
            return String(Int(job.id!)! + 1)
        } else {
            return "1"
        }
    }
    
    func getTaskID(job: Job) -> String {
        let tasks: [Task] = getAllTask(job: job)
        if let task = tasks.last {
            return String(Int(task.id!)! + 1)
        } else {
            return "1"
        }
        // let lastID = Int((tasks.last?.id)!)
        // return String(lastID! + 1)
    }
    
    func setTaskText(jobID: String, taskID: String, text: String) {
        let task = getTask(job: getJob(id: jobID)!, id: taskID)
        task?.text = text
        saveData()
        print("Task text was set")
    }
    
    func setTaskText(task: Task, text: String){
        task.text = text
        saveData()
        print("Task text was set")
    }
    
    func setTaskPhoto(jobID: String, taskID: String, photo: UIImage) {
        let task = getTask(job: getJob(id: jobID)!, id: taskID)!
        fileSystemManager.deletImage(URLString: NSHomeDirectory() + "/Documents/Images/" + task.photo!)
        fileSystemManager.saveImage(task: task, image: photo, quality: 1.0, nameWithExtension: task.photo!)
        saveData()
        print("Task image was set")
    }
    
    func setTaskPhoto(task: Task, photo: UIImage){
        fileSystemManager.deletImage(URLString: NSHomeDirectory() + "/Documents/Images/" + task.photo!)
        fileSystemManager.saveImage(task: task, image: photo, quality: 1.0, nameWithExtension: task.photo!)
        saveData()
        print("Task image was set")
    }
    
    
    func setTaskVideo(jobID: String, taskID: String, videoURLString: String) {
        let task = getTask(job: getJob(id: jobID)!, id: taskID)!
        fileSystemManager.deletVideo(URLString: NSHomeDirectory() + "/Documents/Videos/" + task.video!)
        fileSystemManager.saveVideo(task: task, videoFromURLString: videoURLString, nameWithExtension: task.video!)
        saveData()
        print("Task video was set")
    }
    
    func setTaskVideo(task: Task, videoURLString: String){
        fileSystemManager.deletVideo(URLString: NSHomeDirectory() + "/Documents/Videos/" + task.video!)
        fileSystemManager.saveVideo(task: task, videoFromURLString: videoURLString, nameWithExtension: task.video!)
        saveData()
        print("Task video was set")
    }
    
    func setTaskAudio(jobID: String, taskID: String, audioURLString: String) {
        let task = getTask(job: getJob(id: jobID)!, id: taskID)!
        fileSystemManager.deletAudio(URLString: NSHomeDirectory() + "/Documents/Audios/" + task.audio!)
        fileSystemManager.saveAudio(task: task, audioFromURLString: audioURLString, nameWithExtension: task.audio!)
        saveData()
        print("Task audio was set")
    }
    
    func setTaskAudio(task: Task, audioURLString: String){
        fileSystemManager.deletAudio(URLString: NSHomeDirectory() + "/Documents/Audios/" + task.audio!)
        fileSystemManager.saveAudio(task: task, audioFromURLString: audioURLString, nameWithExtension: task.audio!)
        saveData()
        print("Task audio was set")
    }
    
    func startAnalytics(task: Task) {
        let analytics = Analytics(context: context)
        analytics.startAnalytics(date: Date())
        task.addToHas(analytics)
        saveData()
        print("Analytics started...")
    }
    
    func saveAnalytics(task: Task, desc: String){
         // what was used
//        let title = task.title!
        let analyticsArray = task.has?.array as! [Analytics]
        if analyticsArray.last?.isStarted == true {
            analyticsArray.last?.saveAnalytics(newDate: Date(), description: desc)
        }
        saveData()
        print("Task analytics were saved")
    }
    
    func resourceExists(URLString: String) -> Bool {
        if fileSystemManager.fileManager.fileExists(atPath: URLString) {
            return true
        }
        else {
            return false
        }
    }
    
}
