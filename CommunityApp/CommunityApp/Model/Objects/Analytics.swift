//
//  Analytics.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-26.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

class Analytics {
    
    var date: Date = Date()
    var duration: TimeInterval!
    
    
    init() {
        duration = Date().timeIntervalSince(Date())
    }
    
    
}
