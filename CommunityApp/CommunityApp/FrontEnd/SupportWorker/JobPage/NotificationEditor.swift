//
//  NotificationEditor.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-06-23.
//  Copyright © 2018 Javon Luke. All rights reserved.
//
/*
import Foundation
import UIKit
import UserNotifications
class NotificationEditor: UIViewController {
    
    var jobID: String!
    
    
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
       //  configueUserNotificationCenter()
    }
    
    private func notificationCategory() -> String {
        return jobID
    }
    
  
    

    
    
    
    private func createNotificationRequest(notificationContent: UNMutableNotificationContent, date: DateComponents, repeats: Bool) -> UNNotificationRequest {
        
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: repeats)
        //UNTimeIntervalNotificationTrigger(timeInterval: 10.0 , repeats: false)
        let notificationIdentifier = Notification.Category.job
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: notificationTrigger)
        return request
    }
    
    private func scheduleTaskNotification() {
        
        
    }
    
    
    
    private func createNotificationContent(title: String, body: String) -> UNMutableNotificationContent{
        
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.body = body
        return notificationContent
    }
    
    
    private func scheduleLocalNotification() {
        /*  let notificationContent = createNotificationContent(title: notificationTitle.text, subTitle: notificationSubTitle.text, body: notificationBody.text)
         let notificationRequest = createJobNotificationRequest(notificationContent: notificationContent, date: notificationDate, repeats: notificationDateRepeats)
         UNUserNotificationCenter.current().add(notificationRequest) { (error) in
         if error != nil {
         print("Cannot add this request")
         }
         }
         */
        
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
                
            }
        })}
    
}













extension NotificationEditor: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case Notification.Action.showJob:
            let nav = UIApplication.shared.keyWindow?.rootViewController as? UINavigationController
            let mainViewController = nav?.topViewController as! FrontPage
            
            mainViewController.performSegue(withIdentifier: Constant.segueID.JobManager, sender: self)
            print("set for job")
        case Notification.Action.dismiss:
            print("dismissed")
        default:
            print("default")
            
        }
        completionHandler()
        
    }
    
    
    
}


extension NotificationEditor {
    
  
    
    
}
 */



