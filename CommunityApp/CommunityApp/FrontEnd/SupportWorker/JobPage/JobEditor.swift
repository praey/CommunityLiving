//
//  JobEditor.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-09.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class JobEditor: UIViewController  {
    static let segueID = "toJobEditor"
    
    @IBOutlet weak var taskTitle: UITextField!
    @IBOutlet weak var saveJob: UIButton!
    @IBOutlet weak var addTask: UIButton!
    var job: Job!
    let cellReuseIdentifier = "JobEditorCell"
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleValue: UITextField!
    var tappedTableRow: Task!
    var data: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Entered JobEditor")
        tableView.delegate = self
        tableView.dataSource = self
       
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)

        addTask.addTarget(self, action: #selector(JobEditor.createTask), for: .touchUpInside)
        
        saveJob.addTarget(self, action: #selector(JobEditor.recordJob), for: .touchUpInside)
        
         configueUserNotificationCenter()
       
        
        if let title = job.title {
            titleValue.text = title
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.job = CoreDataManager.database.getJob(jobID: job.id!)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func createTask() {
        if (taskTitle.text?.isEmpty)! {
            print("Task title is empty!")
        }
        else {
            tappedTableRow = CoreDataManager.database.createTask(job: job, title: taskTitle.text!)
            performSegue(withIdentifier: TaskManager.segueID, sender: self)
        }
    }
    
    @objc func recordJob() {
        CoreDataManager.database.saveData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == TaskManager.segueID {
            let vc = segue.destination as! TaskManager
            // If there is a default job to set then it will set it
            vc.task = tappedTableRow
        }
    }
}


extension JobEditor: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return job.has!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        
        // This is where the descripion of the UItableView
        cell.backgroundColor = UIColor.black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You selected \(indexPath.row)")
        tappedTableRow =  job.getTask(row: indexPath.row)
        performSegue(withIdentifier: TaskManager.segueID, sender: self)
    }
}





extension JobEditor {
    struct Notification {
        struct Category {
            static let job = "job"
            static let task = "task"
            
        }
        struct Action {
            
            static let dismiss = "dismiss"
            static let showJob = "showJob"
            static let showTask = "showTask"
            
        }
    }
    
    
    private func configueUserNotificationCenter() {
        
        UNUserNotificationCenter.current().delegate = self
        
        let actionShowJob = UNNotificationAction(identifier: Notification.Action.showJob, title: "Show Job", options: [.foreground])
        let actionShowTask = UNNotificationAction(identifier: Notification.Action.showTask, title: "Show Task", options: [.foreground])
        let actionDismiss = UNNotificationAction(identifier: Notification.Action.dismiss, title: "Dismiss", options: [.destructive])
        
        let jobCategory = UNNotificationCategory(identifier: Notification.Category.job, actions: [actionShowJob,actionDismiss], intentIdentifiers: [], options: [])
        let taskCategory = UNNotificationCategory(identifier: Notification.Category.task, actions: [actionShowTask,actionDismiss], intentIdentifiers: [], options: [])
        
        // Register category
        UNUserNotificationCenter.current().setNotificationCategories([jobCategory,taskCategory])
    }
    
    
    
    private func createJobNotificationRequest(notificationContent: UNMutableNotificationContent, date: DateComponents, repeats: Bool) -> UNNotificationRequest {
        
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: repeats)//UNTimeIntervalNotificationTrigger(timeInterval: 10.0 , repeats: false)
        let notificationIdentifier = Notification.Category.job
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: notificationTrigger)
        return request
    }
    
    private func scheduleTaskNotification() {
        
        
    }
    
    
    
    private func createNotificationContent(title: String, subTitle: String, body: String) -> UNMutableNotificationContent{
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.subtitle = subTitle
        notificationContent.body = body
        notificationContent.userInfo = [AnyHashable("JobID") : job.id!]
        return notificationContent
    }
    
    
    private func scheduleLocalNotification() {
      /*  let notificationContent = createNotificationContent(title: notificationTitle.text, subTitle: notificationSubTitle.text, body: notificationBody.text)
        let notificationRequest = createJobNotificationRequest(notificationContent: notificationContent, date: notificationDate, repeats: notificationDateRepeats)
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if error != nil {
                print("Cannot add this request")
            }
        }*/
        
    }
    
    
    private func saveNotification() {
        
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {
            (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .authorized:
                print("user notification accepted")
                self.scheduleLocalNotification()
            case .notDetermined:
                print("usernotifcation not determined")
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.badge,.alert], completionHandler: {(sucess, error) in guard sucess else {return}
                    self.scheduleLocalNotification()
                }
                )
            case .denied:
                print("User notification denied")
                UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.badge,.alert], completionHandler: {(sucess, error) in guard sucess else {return}
                    self.scheduleLocalNotification()
                }
                )
                
            default:
                print("usernotifcation default")
            }
        })}
    
        
    }
    

extension JobEditor: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case Notification.Action.showJob:
            let nav = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
            let mainViewController = nav?.topViewController as! FrontPage
            
            mainViewController.performSegue(withIdentifier: JobManager.segueID, sender: self)
            print("set for job")
        case Notification.Action.showTask:
            print("set for task")
        case Notification.Action.dismiss:
            print("dismissed")
        default:
            print("default")
            
        }
        completionHandler()
        
    }
    
    
    
}
















