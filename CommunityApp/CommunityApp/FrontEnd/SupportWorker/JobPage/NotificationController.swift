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



/*
class NotificationController: UITableViewController {
   
    let cellReuseIdentifier = Constant.cellReuseIdentifier
    let job: Job!
    var addNotification: UIBarButtonItem!
    let notificationCenter = UNUserNotificationCenter.current()
    var notificationRequests: [UNNotificationRequest]!
    var tappedTableRow: UNNotificationRequest!
    
    
    override func viewDidLoad() {
   
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        addNotification = UIBarButtonItem(title: "Add Notification", style: .plain, target: self, action: #selector(NotificationController.createNotification))
        
        configueUserNotificationCenter()
    }
    
    @objc func createNotification() {
        
        performSegue(withIdentifier: Constant.segueID.NotificationEditor, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let group = DispatchGroup()
        group.enter()
        
        notificationCenter.getPendingNotificationRequests(completionHandler: { requests in
            
            DispatchQueue.global().async {
                self.notificationRequests = requests
                group.leave()
            }})
        group.wait()
        tableView.reloadData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segueID.NotificationEditor {
            let vc = segue.destination as! NotificationEditor
            vc.jobID = self.job.id!
        }
    }
    
    
    private func configueUserNotificationCenter() {
        
        UNUserNotificationCenter.current().delegate = self
        
        let actionShowJob = UNNotificationAction(identifier: Notification.Action.showJob, title: "Show Job", options: [.foreground])
        let actionDismiss = UNNotificationAction(identifier: Notification.Action.dismiss, title: "Dismiss", options: [.destructive])
        
        let category = UNNotificationCategory(identifier: Notification.Category.job, actions: [actionShowJob,actionDismiss], intentIdentifiers: [], options: [])
        
        
        // Register category
        UNUserNotificationCenter.current().setNotificationCategories([category])
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Notifications Pending: ")
        // var pendingCount: Int
        return notificationRequests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        let title = notificationRequests[indexPath.row].content.title
        
        cell.textLabel?.text = title
  
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
        tappedTableRow = notificationRequests[indexPath.row]
        performSegue(withIdentifier: Constant.segueID.NotificationEditor, sender: self)
    }
}
 
 */
    
    
    
    
    
    
    
