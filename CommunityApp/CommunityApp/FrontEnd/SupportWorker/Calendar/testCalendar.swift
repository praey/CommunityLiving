//
//  testCalendar.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-06-16.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
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

class CalendarViewControlle: UIViewController {
    
    struct Notification {
        struct Category {
            static let tutorial = "tutorial"
        }
        struct Action {
            static let readLater = "readLater"
            static let showDetails = "showDetail"
            static let unsubscribe = "unsubscribe"
        }
    }
    
    
    @IBOutlet weak var text: UITextView!
    var store: EKEventStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configueUserNotificationCenter()
        
        //    store = EKEventStore()
        
        
    }
    
    @IBAction func remove(_ sender: Any) {
    }
    @IBAction func fetch(_ sender: Any) {
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings(completionHandler: {
            (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .authorized:
                let content = UNMutableNotificationContent()
                content.title = "testing notification"
                content.body = "Every time"
                content.subtitle = "subtitle"
                
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0 , repeats: false)
                let uuidString = UUID().uuidString
                let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
                notificationCenter.add(request) { (error) in
                    if error != nil {
                        print("doens't equal null")
                    }
                    
                }
                print("set notification")
            default:
                notificationCenter.requestAuthorization(options: [.sound,.badge,.alert], completionHandler: {(sucess, error) in guard sucess else {return}})
            }
        })}
    @IBAction func create(_ sender: Any) {
        
        store.requestAccess(to: .event, completion: {result, error in
            if result && (error == nil){
                print("successfully added calendar")
                let event = EKEvent.init(eventStore: self.store)
                event.title = "eventTitle"
                event.startDate = Date().noon
                event.endDate = Date().tomorrow
                event.notes = "this is a note"
                //event.isAllDay = true
                //var recurrenceRule = EKRecurrenceRule.init(recurrenceWith: EKRecurrenceFrequency.daily, interval: 5, end: nil)
                //  recurrenceRule.frequency = EKRecurrenceFrequency.daily
                //event.addRecurrenceRule(recurrenceRule)
                
                // let calendar = EKCalendar.init(for: .event, eventStore: self.store)
                //event.calendar = calendar
                let calendar = self.store.defaultCalendarForNewEvents!
                
                
                event.calendar = calendar
                var alarm = EKAlarm.init(absoluteDate: Date().tomorrow)
                
                
                event.addAlarm(alarm)
                do {
                    try self.store.save(event, span: EKSpan.futureEvents, commit: true)
                    // event.alarm = alarm
                } catch {
                    print("\(error.localizedDescription)")
                }
            } else {
                print("didn't add calendar")
            }
            if let error = error {
                print(error.localizedDescription)
            }
        })
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func configueUserNotificationCenter() {
       
        
        let actionReadLater = UNNotificationAction(identifier: Notification.Action.readLater, title: "ReadLater", options: [])
        let actionShowDetails = UNNotificationAction(identifier: Notification.Action.showDetails, title: "Show Details", options: [.foreground])
        let actionUnsubscribe = UNNotificationAction(identifier: Notification.Action.unsubscribe, title: "Unsubscribe", options: [.destructive,.authenticationRequired])
        
        let tutorialCategory = UNNotificationCategory(identifier: Notification.Category.tutorial, actions: [actionReadLater,actionShowDetails,actionUnsubscribe], intentIdentifiers: [], options: [])
        
        // Register category
        UNUserNotificationCenter.current().setNotificationCategories([tutorialCategory])
    }
    
 
    
}





    

