//
//  Email.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-09.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit
import MessageUI
import CloudKit
import CoreData




class Email: UIViewController, MFMailComposeViewControllerDelegate {
    
    
    var icloud: ICloudAPI?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Email"
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        icloud = ICloudAPI()
    }
 
    
    func csvFormat(strings: [String], end: Bool = false) -> String {

        var content: String = String.init()
        
        for (index, _) in strings.enumerated() {
            content.append(strings[index])
            if index == (strings.count - 1) {
                
                if end {
                    content.append(Constant.enter)
                }
                break
            } else {
                content.append(Constant.comma)
            }
        }
        
    
        
        
        return content
    }
    

    func getCSVAnalytics() -> String {
        var csvText = ""
        csvText += Constant.getPersonName()! + Constant.enter
        //all jobs
        for job in CoreDataManager.database.getJobs(include: true) {
           
            csvText += "JobTitle," + job.title! + Constant.enter
            // all Analytics
            var analytics: [Analytics] = []
            
            for task in job.getTasks(include: true) {
                for analytic in task.getAnalytics() {
                    analytics.append(analytic)
                }
            }
            
            // sort analytics in ascending order
            analytics.sort(by: {($0.startTime! as Date) < ($1.startTime! as Date)})
            
            for analytic in analytics {
                
                // verifies that the analytic belongs to a task
                guard let task = analytic.belongs else {continue}
                
                var taskTitle: String!
                if let title = task.title, !title.isEmpty {
                   taskTitle = title
                } else {
                    taskTitle = "Default Title"
                }
                taskTitle += Constant.comma
             
                let taskType = csvFormat(strings: task.csvTaskType()) + Constant.comma
                
                let startTime = analytic.getStarttime() + Constant.comma
                let duration = analytic.getDuration()
                
                
                
                csvText += taskTitle + taskType + startTime + duration + Constant.enter
            }
        }
        return csvText
    }
    
    
    func getFileName()->String {
        var num = 0
        var file: String = ""
        let personName = Constant.getPersonName()!
        if let icloud = icloud {
        while true {
            file = "\(personName)\(num).csv"
            
            if !(icloud.fileExists(path: file)) {
                break
            }
            
            
            num += 1
        }
        }
        
        return file
    }
    
    @IBAction func removeCSV(_ sender: Any) {
        let warningAlert = UIAlertController(title: "Warning!", message: "Are you sure that you want to remove all the CSV's?", preferredStyle: .alert)
        warningAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: removeAllCSV))
        warningAlert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        self.present(warningAlert, animated: true, completion: nil)

    }
    
    
    func removeAllCSV(alert: UIAlertAction) {
        if let icloud = icloud {
            icloud.removeFiles()
        } else {
            print("ICloud doens't work")
        }
    }
    
     @IBAction func createCSV() {
        if let icloud = icloud {
        icloud.createDirectory()
        let fileName = getFileName()
        print(fileName)
        let url = icloud.createURL(fileName)
            print(url)
        let text = getCSVAnalytics()
        print("Text: \(text)")
        
        icloud.writeFile(urlLocation: url, text: text)
            
            let successAlert = UIAlertController(title: "Success!", message: "You have successfully sent the csv to the users ICloud account. Log into www.icloud.com - with their credentials and you will see it in their IDrive.", preferredStyle: .alert)
            successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(successAlert, animated: true, completion: nil)

            
        }
        else {
            let failureAlert = UIAlertController(title: "Failure!", message: "The csv has not been sent to icloud. Retry. Make sure that you are logged into ICloud on the device.", preferredStyle: .alert)
            failureAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(failureAlert, animated: true, completion: nil)

            print("ICloud doesn't work")
        }
    }
    
    func analyticTitles() -> String {
        return ""
    }
    
    func requestICloudAccess() {
        
    }
    
 
   /* func getCSVText() -> String {
        var csvText = ""
        for job in CoreDataManager.database.getJobs(include: true) {
            //Constant.comma
            
            csvText += "JobTitle," + job.title! + Constant.enter
            for task in job.getTasks(include: true) {
                let title = task.title ?? "Default Title"
                
                let taskType = csvFormat(strings: task.csvTaskType(), end: true)
                //Constant.comma + Constant.comma +
                csvText += "TaskTitle:," + title + Constant.comma + taskType
                for analytics in task.getAnalytics() {
                    
                    let startTime = analytics.getStarttime()
                    let duration = analytics.getDuration()
                    // let beginning = Constant.comma + Constant.comma + Constant.comma
                    let middle = startTime + Constant.comma + duration
                    let end = Constant.enter
                    csvText += middle + end
                }
            }
        }
        return csvText
    }*/
    

    
 
    
 
 







}








