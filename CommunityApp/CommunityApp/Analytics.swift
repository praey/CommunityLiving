//
//  Analytics.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/5/30.
//  Copyright © 2018年 Javon Luke. All rights reserved.
//

import Foundation

class Analytics: NSObject {
    var startTime: Date = Date()
    //var finishTime: Date
    var duration: TimeInterval = 0.0
    
    public init(date: Date) {
        startTime = date
    }
    
    func saveAnalytics(newDate: Date) {
       // duration = self.date.timeIntervalSince(newDate)
   }
    
    func getAnalytics() -> String {
        var csvText: String = ""
        csvText += startTime.description
        csvText += ","
        csvText += duration.description
        
        return csvText
    }
    
}


