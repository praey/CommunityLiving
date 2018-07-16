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


class Email: UIViewController, MFMailComposeViewControllerDelegate {
    var document: MyDocument?
    var documentURL: URL?
    var ubiquityURL: URL?
    let filemanager = FileManager.default
    
    let name = Constant.getUsername()
    let email = Constant.getEmail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if FileManager.default.url(forUbiquityContainerIdentifier: nil) != nil {
            print("logged into icloud")
        } else {
            print("no account to log into")
        }
        if let _ = filemanager.ubiquityIdentityToken {
            requestICloudAccess()
        }
        
        ubiquityURL = filemanager.url(forUbiquityContainerIdentifier: nil)
        guard ubiquityURL != nil else {
            print("unable to access icloud account")
            return
        }
        
        ubiquityURL = ubiquityURL?.appendingPathComponent("Documents/+\(Constant.personName).csv")
        document = MyDocument(fileURL: ubiquityURL!)
       
    }
    
    func analyticTitles() -> String {
        return ""
    }
    
    func requestICloudAccess() {
        
    }
    
    @IBAction func createCSV() {
  
        
        var csvText: String = ""
        csvText += Constant.personName + Constant.enter
        
        
        // getJobs
        //get Tasks // get analytics // organize analytics from task print out analytics.belongs to 
        
        
 
       // csvText += getCSVText()
        
        
        
        csvText += getCSVAnalytics()
        
        
        
        
      
        
    
       
        
        document!.csvText = csvText
        document?.save(to: ubiquityURL!, for: .forCreating, completionHandler: {(success: Bool) -> Void in
            if success {
                print("success")
                DispatchQueue.main.async {
                    self.writeEmail()
                }
                
            } else {
                print("failure")
            }
        })
        
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
    
    
    
    func getCSVText() -> String {
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
    
    
    
    func writeEmail() {
        
        var emailURL: URL? = nil
        do {
            emailURL = try filemanager.url(forPublishingUbiquitousItemAt: ubiquityURL!, expiration: nil)
            print("opened email")
        } catch {
            print("Cannot open email")
        }
        // let fileName = "CommunityLiving.csv"
        
        if MFMailComposeViewController.canSendMail() {
            let emailController = MFMailComposeViewController()
            
            emailController.mailComposeDelegate = self
            emailController.setToRecipients(self.email!)
            emailController.setSubject("Comunity Living")
            if let emailURL = emailURL {
                emailController.setMessageBody("Link: " + (emailURL.absoluteString), isHTML: false)
            }
            
            present(emailController, animated: true, completion: nil)
        } else {
            print("cant send mail")
        }
        
}
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        var needToSegue = false
        switch result {
        case .sent:
            print("Mail sent")
            needToSegue = true
            
        case .cancelled:
            print("Mail Cancelled")
            
        case .failed:
            print("Mail failed: \(error?.localizedDescription ?? "nil")")
            
        case .saved:
            print("Mail saved")
        }
        
        controller.dismiss(animated: true) {
            if needToSegue {
                //self.performSegue(withIdentifier: Constant., sender: self)
            }
        }
    }








}


class MyDocument: UIDocument {
    var csvText: String? = "defualt text"
    
    override func contents(forType typeName: String) throws -> Any {
        if let content = csvText {
            let length = content.lengthOfBytes(using: .utf8)
            return NSData.init(bytes: content, length: length)
        } else {
            return Data()
        }
    }
    
    override func load(fromContents contents: Any, ofType typeName: String?) throws {
        if let userContent = contents as? Data {
            csvText = NSString(bytes: (contents as AnyObject).bytes, length: userContent.count, encoding: String.Encoding.utf8.rawValue) as String?
        }
    }
    
}




