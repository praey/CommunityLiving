//
//  Analytics+CoreDataProperties.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/7/4.
//  Copyright © 2018年 Javon Luke. All rights reserved.
//
//

import Foundation
import CoreData


extension Analytics {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Analytics> {
        return NSFetchRequest<Analytics>(entityName: "Analytics")
    }

    @NSManaged public var duration: DateComponents?
    @NSManaged public var isStarted: Bool
    @NSManaged public var startTime: NSDate?
    @NSManaged public var taskDescription: String?
    @NSManaged public var belongs: Task?

}
