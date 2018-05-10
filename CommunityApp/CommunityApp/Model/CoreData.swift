//
//  CoreData.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-10.
//  Copyright © 2018 Javon Luke. All rights reserved.
//

import Foundation
import UIKit

final class CoreData {
    
    // I will need functions to
    //Create, Retrieve, Update, and Delete
    // single Jobs
    // multiple Jobs
    // single Tasks
    // multiple Tasks
    // AnalyticData
    // I would like all of these functions to be static
    private init() { }
    
    
    static func getJobs() -> [Job] {
       return Job.tempJobs()
    }

}
