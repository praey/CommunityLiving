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
    var pickerData: [String]!
    var pickerSelection: String!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var repeatPicker: UIPickerView!
    
    
    @IBOutlet weak var addNotification: UIButton!

    
    
    struct NotificationRepeat {
        static let never = "never"
        static let daily = "daily"
        static let weekly = "weekly"
        static let monthly = "monthly"
        static let yearly = "yearly"
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
        pickerData = [NotificationRepeat.never,NotificationRepeat.daily,NotificationRepeat.weekly,NotificationRepeat.monthly,NotificationRepeat.yearly]
        repeatPicker.delegate = self
        repeatPicker.dataSource = self
        datePicker.setDate(Date(), animated: true)
        
            // UNUserNotificationCenter.current().delegate = self
        // UNUserNotification.curr = self
        
       //  configueUserNotificationCenter()
    }
    
   // private func notificationCategory() -> String {
    //    return jobID
   // }
    
    private func createNotificationRequest(notificationContent: UNMutableNotificationContent, date: DateComponents, repeats: Bool) -> UNNotificationRequest {
        
        let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: repeats)
        //let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 10.0 , repeats: false)
        let notificationIdentifier = "showJob"
        let request = UNNotificationRequest(identifier: notificationIdentifier, content: notificationContent, trigger: notificationTrigger)
        return request
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
        
        
        let notificationDate = getDateComponents() ?? DateComponents()
        
      
        let repeats: Bool = !(pickerSelection == NotificationRepeat.never)
        
        
        let notificationRequest = createNotificationRequest(notificationContent: notificationContent, date: notificationDate, repeats: repeats)
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
    
    
    func getDateComponents() -> DateComponents? {
        
        //Calendar.Component.
        
        var notificationDate: DateComponents?
        
        if pickerSelection == NotificationRepeat.never {
            return nil
        } else
        if pickerSelection == NotificationRepeat.daily {
            notificationDate = datePicker.calendar.dateComponents(([.hour, .minute, .second]), from: datePicker.date)
        } else
        if pickerSelection == NotificationRepeat.weekly {
            notificationDate = datePicker.calendar.dateComponents(([.hour, .minute, .second,.weekday]), from: datePicker.date)
        } else
        
        if pickerSelection == NotificationRepeat.monthly {
            notificationDate = datePicker.calendar.dateComponents(([.hour, .minute, .second,.day]), from: datePicker.date)
        } else
        
        if pickerSelection == NotificationRepeat.yearly {
            notificationDate = datePicker.calendar.dateComponents(([.hour, .minute, .second,.day,.month]), from: datePicker.date)
            
        } else {
            fatalError()
        }
        
        return notificationDate
        
        
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














extension NotificationEditor: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerSelection = pickerData[row]
    }
}


 



