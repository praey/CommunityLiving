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
        
        ubiquityURL = filemanager.url(forUbiquityContainerIdentifier: nil)
        guard ubiquityURL != nil else {
            print("unable to access icloud account")
            return
        }
        ubiquityURL = ubiquityURL!.appendingPathComponent("Documents/+\(self.name).csv")
        document = MyDocument(fileURL: ubiquityURL!)
    }
    
    func analyticTitles() -> String {
        return ""
    }
    
    
    
    @IBAction func createCSV() {
        var csvText: String = ""
        csvText += analyticTitles()
        for job in CoreDataManager.database.getJobs() {
            for task in job.getTasks() {
                csvText += task.getAnalytics()
            }
        }
        
        document!.csvText = csvText
        document?.save(to: ubiquityURL!, for: .forCreating, completionHandler: {[weak self](success: Bool) -> Void in
            if success {
                print("success")
                self?.writeEmail()
            } else {
                print("failure")
            }
        })
        
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




