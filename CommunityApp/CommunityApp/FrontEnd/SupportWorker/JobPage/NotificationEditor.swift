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
    var pickerSelection: String?
    
    @IBOutlet weak var titleValue: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var bodyValue: UITextField!
    @IBOutlet weak var repeatPicker: UIPickerView!
    
    
    @IBOutlet weak var addNotification: UIButton!

    var titleNotification: String!
    var body: String!
    
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
        
        titleValue.text = title
            bodyValue.text = body
        
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
        
        
        let notificationContent = createNotificationContent(title: titleValue.text ?? "", body: bodyValue.text ?? "")
        
        
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
        
        var notificationDate: DateComponents?
        
        guard let selection = pickerSelection else { return nil }
        
        if selection == NotificationRepeat.never {
            notificationDate = datePicker.calendar.dateComponents(([.day,.hour, .minute, .second]), from: datePicker.date)
        } else
        if selection == NotificationRepeat.daily {
            notificationDate = datePicker.calendar.dateComponents(([.hour, .minute, .second]), from: datePicker.date)
        } else
        if selection == NotificationRepeat.weekly {
            notificationDate = datePicker.calendar.dateComponents(([.hour, .minute, .second,.weekday]), from: datePicker.date)
        } else
        
        if selection == NotificationRepeat.monthly {
            notificationDate = datePicker.calendar.dateComponents(([.hour, .minute, .second,.day]), from: datePicker.date)
        } else
        
        if selection == NotificationRepeat.yearly {
            notificationDate = datePicker.calendar.dateComponents(([.hour, .minute, .second,.day,.month]), from: datePicker.date)
            
        }
        
        
        
        return notificationDate
        
        
    }
    
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    
    @objc private func saveNotification() {
        
        UNUserNotificationCenter.current().getNotificationSettings(completionHandler: {
            (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .authorized:
                print("user notification accepted")
                DispatchQueue.main.async {
                    self.presentAlert(title: "Notification", message: "Accpted")
                    self.scheduleLocalNotification()
                }
            case .notDetermined:
                print("usernotifcation not determined")
                DispatchQueue.main.async {
                    
                
                self.presentAlert(title: "Notification", message: "Could not be determined")
                UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.badge,.alert], completionHandler: {(sucess, error) in guard sucess else {return}
                    
                }
                )
                }
            case .denied:
                print("User notification denied")
                DispatchQueue.main.async {
                    
                
                self.presentAlert(title: "Denied", message: "Notifications was denied")
                UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.badge,.alert], completionHandler: {(sucess, error) in guard sucess else {return}
                    
                }
                )
                }
           // case .provisional:
             //   print("provisional status")
               // self.scheduleLocalNotification()
            default:
                DispatchQueue.main.async {
                    self.presentAlert(title: "Alert couldn't be determined", message: "Notification are undetermined")
                
                UNUserNotificationCenter.current().requestAuthorization(options: [.sound,.badge,.alert], completionHandler: {(sucess, error) in guard sucess else {return}
                    
                }
                )
                }
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


 



