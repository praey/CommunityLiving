//
//  Job+CoreDataProperties.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/5/23.
//  Copyright © 2018年 Javon Luke. All rights reserved.
//
//

import Foundation
import CoreData


extension Job {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: "Job")
    }

    @NSManaged public var date: String?
    @NSManaged public var disabelJob: String?
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var has: NSSet?

}

// MARK: Generated accessors for has
extension Job {

    @objc(addHasObject:)
    @NSManaged public func addToHas(_ value: Task)

    @objc(removeHasObject:)
    @NSManaged public func removeFromHas(_ value: Task)

    @objc(addHas:)
    @NSManaged public func addToHas(_ values: NSSet)

    @objc(removeHas:)
    @NSManaged public func removeFromHas(_ values: NSSet)

}
