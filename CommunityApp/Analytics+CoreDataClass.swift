//
//  Analytics+CoreDataClass.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/7/2.
//  Copyright © 2018年 Javon Luke. All rights reserved.
//
//

import Foundation
import CoreData


public class Analytics: NSManagedObject {
    
    /*
     * These functions shouldn't be used directly from frontend
     * The functions about analytic data which are needed by frontend
     * should all be in CoreDataManager class
     */
    
    func startAnalytics(date: Date) {
        startTime = date as NSDate
        duration = nil
        taskDescription = ""
        isStarted = true
    }
    
    func saveAnalytics(newDate: Date, description: String) {
        let calendar = NSCalendar.current
        let unitsNeeded: Set = Set<Calendar.Component>([.hour, .minute, .second])
        duration = calendar.dateComponents(unitsNeeded, from: startTime! as Date, to: newDate)
        taskDescription = description
        isStarted = false
    }
    
    func getAnalytics() -> String {
        var csvText: String = ""
        csvText += (startTime?.description)!
        csvText += ","
        csvText += (duration?.description)!
        return csvText
    }
}
