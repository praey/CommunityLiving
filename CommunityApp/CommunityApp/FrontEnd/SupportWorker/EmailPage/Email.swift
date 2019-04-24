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
    
    
    //let name = Constant.getUsername()
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
        for word in strings {
            content.append(word)
            if word == strings.last! {
                if end {
                    content.append(Constant.enter)
                }
            } else {
                content.append(Constant.comma)
            }
        }
        return content
    }
    

    func getCSVAnalytics() -> String {
        var csvText = ""
        for job in CoreDataManager.database.getJobs(include: true) {
            //Constant.comma
            csvText += "JobTitle," + job.title! + Constant.enter
            // all Analytics
            var analytics: [Analytics] = []
            for task in job.getTasks(include: true) {
                for analytic in task.getAnalytics() {
                    analytics.append(analytic)
                }
            }
            // sort analytics
            analytics.sort(by: {($0.startTime! as Date) < ($1.startTime! as Date)})
            
            for analytic in analytics {
                
                guard let task = analytic.belongs else {continue}
                
                let taskTitle = task.title ?? "Default Title"
                let taskType = csvFormat(strings: task.csvTaskType())
                
                let startTime = analytic.getStarttime()
                let duration = analytic.getDuration()
                
                
                csvText += taskTitle + Constant.comma + taskType + Constant.comma + startTime + Constant.comma + duration + Constant.enter
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
        let fileName = getFileName()
        print(fileName)
        let url = icloud.createURL(fileName)
        let text = getCSVAnalytics()
        print("Text: \(text)")
        
        icloud.writeFile(urlLocation: url, text: text)
        }
        else {
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








