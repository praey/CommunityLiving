//
//  Analytics.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/5/30.
//  Copyright © 2018年 Javon Luke. All rights reserved.
//

import Foundation

class Analytics: NSObject {
    var date: Date
    var duration: TimeInterval
    
    public init(dat: Date, dur: TimeInterval) {
        date = dat
        duration = dur
    }
}
