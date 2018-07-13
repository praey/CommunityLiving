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


class Email: UIViewController, MFMailComposeViewControllerDelegate {
    var document: MyDocument?
    var documentURL: URL?
    var ubiquityURL: URL?
    let filemanager = FileManager.default
    
    let name = Constant.getUsername()
    let email = Constant.getEmail()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let _ = filemanager.ubiquityIdentityToken {
            requestICloudAccess()
        }
       
    }
    
    func analyticTitles() -> String {
        return ""
    }
    
    func requestICloudAccess() {
        
    }
    
    @IBAction func createCSV() {
        guard filemanager.ubiquityIdentityToken != nil else {
            print("User doesn't have access to icloud")
            requestICloudAccess()
            return
            
        }
        ubiquityURL = filemanager.url(forUbiquityContainerIdentifier: nil)
        if let ubiquity = ubiquityURL {
            ubiquityURL = ubiquity.appendingPathComponent("Documents/+\(Constant.personName).csv")
              document = MyDocument(fileURL: ubiquityURL!)
        }
        
        
      
        
    
        var csvText: String = ""
        csvText += Constant.personName + Constant.enter
        
        for job in CoreDataManager.database.getJobs(include: true) {
            csvText += Constant.comma + job.title! + Constant.enter
            for task in job.getTasks(include: true) {
                let title = task.title ?? "Default Title"
                
                let taskType = csvFormat(strings: task.csvTaskType())
                
                
                
                
                csvText += Constant.comma + Constant.comma + title + Constant.comma + taskType + Constant.enter
                for analytics in task.getAnalytics() {
                    let startTime = analytics.startTime!.description
                    let duration = analytics.duration!.description
                    let beginning = Constant.comma + Constant.comma + Constant.comma
                    let middle = startTime + Constant.comma + duration
                    let end = Constant.enter
                    csvText += beginning + middle + end
                }
            }
        }
        
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
    

    
    func csvFormat(strings: [String], middle: Bool = false) -> String {
        var content: String = String.init()
        for word in strings {
            content.append(word)
            if word == strings.last! {
                if !middle {
                    content.append(Constant.enter)
                } else {
                    content.append(Constant.comma)
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
            emailController.setToRecipients([self.email!])
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
                self.performSegue(withIdentifier: "toFinishPage", sender: self)
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




