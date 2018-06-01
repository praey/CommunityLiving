//
//  CoreDataManager.swift
//  CoreDataNewTry
//
//  Created by Tianyuan Zhang on 2018/5/11.
//  Copyright © 2018年 qwe. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject, CoreDataProtocol{

 
    
  
  
  
    func removeTestData() {
        
    }
    

    
    static let database = CoreDataManager()
    lazy var context: NSManagedObjectContext = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        return context
    }()
    
    let fileSystemManager: FileSystemManager = FileSystemManager.fileSystemManager
    
    
    func createTestData() -> [Job]{
        let job = Job(context: context)
        job.id = "1"
        job.title = "Job"
        
        
        let task = Task(context: context)
        task.title = "Task"
        task.id = "2"
        task.jobid = "1"
        fileSystemManager.saveImage(task: task, image: UIImage(named: "photo")!, quality: 1.0, nameWithExtension: "\(task.jobid! + task.id!).jpg")
        
        fileSystemManager.saveVideo(task: task, videoFromURLString: "/Users/TianyuanZhang/Downloads/Wildlife.mp4", nameWithExtension: "\(task.jobid! + task.id!).mp4")

        task.text = "default string"
        job.addToHas(task)
        do{
            try context.save()
            print("Data Saved!")
        }
        catch{
            fatalError()
        }
        var jobs: [Job] = []
        jobs.append(job)
        return jobs
        
    }
    
    
    
    func saveJob(id: String, name: String) -> Job{
        let job = Job(context: context)
        job.id = id
        job.title = name
        do {
            try context.save()
            print("Job is Saved!")
        }
        catch {
            fatalError()
        }
        return job
    }
    
    func getJob(jobID: String) -> Job {
        
        return self.createTestData()[0]
        
        /*let fetchRequest: NSFetchRequest = Job.fetchRequest()
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
        }*/
    }
    
  

    
    func getJobs() -> [Job] {
        let fetchRequest: NSFetchRequest = Job.fetchRequest()
        do {
            let result = try context.fetch(fetchRequest)
            return result            }
        catch {
            fatalError();
        }
    }
    
    func deletAllJobs(){
//        for job in getAllJobs() {
//            deleteAllTasks(job: job)
//            context.delete(job)
//        }
    }
    
    func saveData(job: Job, name: String, id: String, jobid: String){
        let task = Task(context: context)
        task.title = name
        task.id = id
        task.jobid = jobid
        fileSystemManager.saveImage(task: task, image: UIImage(contentsOfFile: "/Users/TianyuanZhang/Desktop/imageDemo.jpg")!, quality: 1.0, nameWithExtension: "\(task.jobid! + task.id!).jpg")
        fileSystemManager.saveVideo(task: task, videoFromURLString: "/Users/TianyuanZhang/Downloads/Wildlife.mp4", nameWithExtension: "\(task.jobid! + task.id!).mp4")
        job.addToHas(task)
        do{
            try context.save()
            print("Data Saved!")
        }
        catch{
            fatalError()
        }
    }
    
    func getTask(jobID: String, taskID: String)->Task?{
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
//        for task in job.has as! Set<Task>{
//            if task.id! == id{
//                return task
//            }
//        }
//        return nil
        return nil
    }
    
//    func getTasks(jobID: Job) -> [Task] {
//        //        let fetchRequest: NSFetchRequest = Task.fetchRequest()
//        //        do {
//        //            let result = try context.fetch(fetchRequest)
//        //            return result
//        //        } catch {
//        //            fatalError();
//        //        }
//        let array = Array(job.has as! Set<Task>)
//        return array
//    }
    
    func deleteAllTasks(job: Job){
//        for task in getTasks(job: job){
//            let documentURLString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
//            let photoURLString = documentURLString + "/" + task.photo!
//            let videoURLString = documentURLString + "/" + task.video!
//            print(documentURLString)
//            context.delete(task)
//            fileSystemManager.deletImage(URLString: photoURLString)
//            fileSystemManager.deletVideo(URLString: videoURLString)
//        }
//        do{
//            try context.save()
//        }
//        catch {
//            fatalError()
//        }
    }
    
    
    func getTaskPhoto() -> UIImage {     let image = UIImage.init(named: "errorImage")!
        return image}
    
    func getTaskText() -> String {
      return "default text"
    }
    /*
    
    func getJobs() -> [Job] {
        return CoreDataManager.coreDataManager.getAllJobs()
    }
    
    func createJob() -> Job {
        let jobID = "1"// CoreDataManager.coreDataManager.getJobID()
        let job = CoreDataManager.coreDataManager.saveJob(id: jobID, name: "default")
        return job
    }
    
    func getJob(id: String) -> Job {
        return CoreDataManager.coreDataManager.saveJob(id: id, name: "default")
    }
    
    */
    
    
}
