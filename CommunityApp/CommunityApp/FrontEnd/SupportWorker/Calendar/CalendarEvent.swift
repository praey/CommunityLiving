//
//  CalendarEvent.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-06-14.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import EventKit
import UIKit
import UserNotifications

class CalendarViewController: UIViewController {
    
    struct Notification {
        struct Category {
            static let tutorial = "tutorial"
            static let job = "job"
            static let task = "task"

        }
        struct Action {
            
            static let dismiss = "dismiss"
            static let showDetail = "showDetail"
            
            
            static let readLater = "readLater"
            static let showDetails = "showDetail"
            static let unsubscribe = "unsubscribe"
        }
    }
    
    
    @IBOutlet weak var text: UITextView!
    
    var notificationCenter = UNUserNotificationCenter.current()
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
  
     
        
    }
    
    @IBAction func remove(_ sender: Any) {
    }
    @IBAction func fetch(_ sender: Any) {

        
        
        notificationCenter.getNotificationSettings(completionHandler: {
            (notificationSettings) in
            switch notificationSettings.authorizationStatus {
                case .authorized:
                    
                    
                  self.scheduleLocalNotification()
                default:
                    self.notificationCenter.requestAuthorization(options: [.sound,.badge,.alert], completionHandler: {(sucess, error) in guard sucess else {return}
                        self.scheduleLocalNotification()
                        
                    }
                )
            }
        })}
    @IBAction func create(_ sender: Any) {}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configueUserNotificationCenter() {
        UNUserNotificationCenter.current().delegate = self
        
        let actionReadLater = UNNotificationAction(identifier: Notification.Action.readLater, title: "ReadLater", options: [])
        let actionShowDetails = UNNotificationAction(identifier: Notification.Action.showDetails, title: "Show Details", options: [.foreground])
        let actionUnsubscribe = UNNotificationAction(identifier: Notification.Action.unsubscribe, title: "Unsubscribe", options: [.destructive,.authenticationRequired])
        
        let tutorialCategory = UNNotificationCategory(identifier: Notification.Category.tutorial, actions: [actionReadLater,actionShowDetails,actionUnsubscribe], intentIdentifiers: [], options: [])
        
        // Register category
        UNUserNotificationCenter.current().setNotificationCategories([tutorialCategory])
    }
    
    private func scheduleLocalNotification() {
        
        let content = UNMutableNotificationContent()
        content.title = "testing notification"
        content.body = "Every time"
        content.subtitle = "subtitle"
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0 , repeats: false)
        let uuidString = Notification.Category.tutorial // UUID().uuidString
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        notificationCenter.add(request) { (error) in
            if error != nil {
                print("doens't equal null")
            }
            
        }
        print("set notification")
        
        
      content.body = "In this tutorial "
        
       content.categoryIdentifier = Notification.Category.tutorial
        
       //let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
    }
    
}

extension CalendarViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case Notification.Action.readLater:
            print("save for later")
        case Notification.Action.unsubscribe:
            print("unsubscribe")
        default:
            print("default")
            
        }
        completionHandler()
        
    }
    
}


extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }

}
