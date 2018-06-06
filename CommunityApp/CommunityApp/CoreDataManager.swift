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
    
    func getTasks(jobID: String) -> [Task] {
        let job = getJob(id: jobID)!
        return getAllTask(job: job)
    }
    
    func getJob(jobID: String) -> Job {
        return getJob(id: jobID)!
    }
    
    func getJobs() -> [Job] {
        return getAllJobs()
    }
    
    func createJob(title: String) -> Job {
        let id = getJobID()
        let job = Job(context: context)
        job.id = id
        job.title = title
        saveData()
        print("Job is Saved!")
        return job
    }
    
    func createTask(job: Job, title: String) -> Task {
        let id = getTaskID(job: job)
        let task = Task(context: context)
        task.title = title
        task.id = id
        task.jobid = job.id
        task.photo = "\(task.jobid! + task.id!).jpg"
        task.video = "\(task.jobid! + task.id!).mp4"
        task.audio = "\(task.jobid! + task.id!).m4a"
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
    
    func deleteTask(jobID: String, taskID: String) {
        let job = getJob(id: jobID)!
        let task = getTask(job: job, id: taskID)!
        context.delete(task)
        saveData()
    }
    
    func ifFileExists(task: Task, fileType: Task.FileType) -> Bool {
        // check if the file exists
        return true
    }
    
    
    func createTestData() -> [Job] {
        var jobs = [Job]()
        let job = createJob(title: "test job 1")
      
        
        
        let newTask = createTask(job: job, title: "test task 2")
        // var path = Bundle.main.path(forResource: "audio.mp3", ofType: nil)!
        
        // setTaskAudio(task: newTask, audioURLString: path)
        
        
        var path = "/Users/newuser/Desktop/audio.mp3"
        setTaskAudio(task: newTask, audioURLString: path)
        
        
        
        
        let task = createTask(job: job, title: "test task 1")
        
         path = "/Users/newuser/Desktop/testVideo.mp4"
        // let url = URL.init(fileURLWithPath: path!)
        setTaskVideo(task: task, videoURLString: path)
        
        
        
        
        
        // path = "/Users/newuser/Desktop/testPhoto.jpg"
        // setTaskPhoto(task: task, photo: UIImage.init(named: "testPhoto")!)
        jobs.append(job)
        
        return jobs
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
//        }
//        let lastID = Int(jobs.last?.id) ?? 0
//        // Int((jobs.last?.id)!)
//        let id = (lastID + 1)
//        return String(id)
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
        task?.disableText = false
        saveData()
        print("Task text was set")
    }
    
    func setTaskText(task: Task, text: String){
        task.text = text
        task.disableText = false
        saveData()
        print("Task text was set")
    }
    
    func setTaskPhoto(jobID: String, taskID: String, photo: UIImage) {
        let task = getTask(job: getJob(id: jobID)!, id: taskID)!
        fileSystemManager.deletImage(URLString: NSHomeDirectory() + "/Documents/Images/" + task.photo!)
        fileSystemManager.saveImage(task: task, image: photo, quality: 1.0, nameWithExtension: task.photo!)
        task.disablePhoto = false
        saveData()
        print("Task image was set")
    }
    
    func setTaskPhoto(task: Task, photo: UIImage){
        fileSystemManager.deletImage(URLString: NSHomeDirectory() + "/Documents/Images/" + task.photo!)
        fileSystemManager.saveImage(task: task, image: photo, quality: 1.0, nameWithExtension: task.photo!)
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
    
    func setTaskVideo(task: Task, videoURLString: String){
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
    
    func setTaskAudio(task: Task, audioURLString: String){
        fileSystemManager.deletAudio(URLString: NSHomeDirectory() + "/Documents/Audios/" + task.audio!)
        fileSystemManager.saveAudio(task: task, audioFromURLString: audioURLString, nameWithExtension: task.audio!)
        task.disableAudio = false
        saveData()
        print("Task audio was set")
    }
    
    func saveAnalytics(task: Task, date: Date, duration: TimeInterval){
        task.analytics = Analytics(dat: date, dur: duration)
        saveData()
        print("Task analytics were saved")
    }
}
