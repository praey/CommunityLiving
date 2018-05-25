//
//  CoreDataManager.swift
//  CoreDataNewTry
//
//  Created by Tianyuan Zhang on 2018/5/11.
//  Copyright © 2018年 qwe. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject{
    
    static let coreDataManager = CoreDataManager()
    lazy var context: NSManagedObjectContext = {
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        return context
    }()
    
    let fileSystemManager: FileSystemManager = FileSystemManager.fileSystemManager
    
    func saveJob(id: String, name: String){
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
    }
    
    func retrieveJob(id: String) -> (Job?){
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
    
    func retrieveTask(job: Job, id: String)->(Task?){
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
        for task in job.has as! Set<Task>{
            if task.id! == id{
                return task
            }
        }
        return nil
    }
    
    func getAllTask(job: Job) -> Set<Task> {
        //        let fetchRequest: NSFetchRequest = Task.fetchRequest()
        //        do {
        //            let result = try context.fetch(fetchRequest)
        //            return result
        //        } catch {
        //            fatalError();
        //        }
        return job.has as! Set<Task>
    }
    
    func deleteAllTasks(job: Job){
        for task in getAllTask(job: job){
            let documentURLString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
            let photoURLString = documentURLString + "/" + task.photo!
            let videoURLString = documentURLString + "/" + task.video!
            print(documentURLString)
            context.delete(task)
            fileSystemManager.deletImage(URLString: photoURLString)
            fileSystemManager.deletVideo(URLString: videoURLString)
        }
        do{
            try context.save()
        }
        catch {
            fatalError()
        }
    }
}
