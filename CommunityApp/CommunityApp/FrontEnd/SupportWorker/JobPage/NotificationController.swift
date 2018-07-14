//
//  NotificationController.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-06-23.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications




class NotificationController: UITableViewController {
   
    let cellReuseIdentifier = Constant.cellReuseIdentifier
    var job : Job!
    var addNotification: UIBarButtonItem!
    let notificationCenter = UNUserNotificationCenter.current()
    var notificationRequests: [UNNotificationRequest]? {
        didSet {
            //self.tableView.reloadData()
        }
    }
    var tappedTableRow: UNNotificationRequest!
    
    
    override func viewDidLoad() {
   
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        addNotification = UIBarButtonItem(title: "Add Notification", style: .plain, target: self, action: #selector(NotificationController.createNotification))
         self.navigationItem.rightBarButtonItem = addNotification
        configueUserNotificationCenter()
    }
    
    @objc func createNotification() {
        performSegue(withIdentifier: Constant.segueID.NotificationEditor, sender: self)
    }
    
    func setJob(job: Job!) {
        self.job = job
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: {requests in
             // Correct
                print("request")
                print(requests.description)
            
                self.notificationRequests = requests//.filter {$0.identifier == self.job.id!}
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        })
      
        
       
        print("yes")
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueID.NotificationEditor {
            let vc = segue.destination as! NotificationEditor
            vc.setJob(job: self.job)
            if let notification = tappedTableRow {
            vc.titleNotification = notification.content.title
            vc.body = notification.content.body
            }
            
        }
    }
    
    
    private func configueUserNotificationCenter() {
        
       // UNUserNotificationCenter.current().delegate = self
        
        let actionShowJob = UNNotificationAction(identifier: "showjob", title: "Show Job", options: [.foreground])
        //let actionDismiss = UNNotificationAction(identifier: Notification.Action.dismiss, title: "Dismiss", options: [.destructive])
        
        let category = UNNotificationCategory(identifier: "job", actions: [actionShowJob], intentIdentifiers: [], options: [])
        
        
        // Register category
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // // var pendingCount: Int
        if let requests = notificationRequests {
            print("Notifications Pending: \(requests.count)")
            return requests.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        if let requests = notificationRequests {
            let title = requests[indexPath.row].content.title
            print("Title for cell: \(title)")
            cell.textLabel?.text = title
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
        if let requests = notificationRequests {
            guard requests.count > indexPath.row else {
               return
            }
            tappedTableRow = requests[indexPath.row]
            
            performSegue(withIdentifier: Constant.segueID.NotificationEditor, sender: self)
        }
        
    }
}


 

    
    
    
    
    
    
    
