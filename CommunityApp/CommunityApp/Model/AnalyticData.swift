//
//  AnalyticData.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-04-27.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class AnalyticData: Codable {
    
    // What is Analytic Data
    // - Analytic Data is defined by the time that it started and the time that it ended
    let startTime: Date!
    
    init() {
        startTime = Date()
    }
    
    func getTimeIntervalSince() -> TimeInterval {
        return Date().timeIntervalSince((startTime)!)
    }
    
}
