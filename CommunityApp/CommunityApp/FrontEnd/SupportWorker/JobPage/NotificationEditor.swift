//
//  NotificationEditor.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-06-23.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications
class NotificationEditor: UIViewController {
    
    var job: Job!
    
    
    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var repeatPicker: UIPickerView!
    
    
    @IBOutlet weak var addNotification: UIButton!

    
    
    enum NotificationRepeat {
        case everyDay
        case everyWeek
        case every2Weeks
        case everyWeekday
        case everyWeekend
        // EveryDay, EveryWeek, Every 2 Weeks, EveryWeekday, EveryWeekend, Every Sunday, Every Monday, Every, Tuesday, Every Wednesday, Every Thursday, Every Friday, Every Saturday
    }

    struct Notification {
        struct Action {
            static let dismiss = "dismiss"
            static let showJob = "showJob"
        }
        struct Category {
            static let job = "job"
        }
        
        enum Alarm {
            case hourBefore
            case dayBefore
            case minuteBefore
        }
  
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        addNotification.addTarget(self, action: #selector(NotificationEditor.saveNotification), for: .touchUpInside)
        
        
        
            // UNUserNotificationCenter.current().delegate = self
        // UNUserNotification.curr = self
        
       //  configueUserNotificationCenter()
    }
    
   // private func notificationCategory() -> String {
    //    return jobID
   // }
    
    private func createNotificationRequest(notificationContent: UNMutableNotificationContent, date: DateComponents, repeats: Bool) -> UNNotificationRequest {
        
        // let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: repeats)
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0 , repeats: false)
        let notificationIdentifier = "showJob"
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: notificationTrigger)
        return request
    }
    
    private func scheduleTaskNotification() {
        
        
    }
    
    
    
    private func createNotificationContent(title: String, body: String) -> UNMutableNotificationContent{
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        notificationContent.userInfo = ["job" : self.job.id! ]
        return notificationContent
    }
    
    func setJob(job: Job!) {
        self.job = job
    }
    
    
    private func scheduleLocalNotification() {
        let notificationContent = createNotificationContent(title: "test title", body: "test body")
        let notificationRequest = createNotificationRequest(notificationContent: notificationContent, date: DateComponents(), repeats: true)
         UNUserNotificationCenter.current().add(notificationRequest) { (error) in
         if error != nil {
         print("Cannot add this request")
         }
         }
        
        
        
       /*
        let notificationContent = createNotificationContent(title: notificationTitle.text, subTitle: notificationSubTitle.text, body: notificationBody.text)
        let notificationRequest = createJobNotificationRequest(notificationContent: notificationContent, date: notificationDate, repeats: notificationDateRepeats)
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if error != nil {
                print("Cannot add this request")
            }
        }
     */
    }
    
    
    
    @objc private func saveNotification() {
        
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
           // case .provisional:
             //   print("provisional status")
               // self.scheduleLocalNotification()
            default:
                print("default")
            }
        })}
    
}














extension NotificationEditor {
    
  
    
    
}
 



