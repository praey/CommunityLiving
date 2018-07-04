//
//  Job+CoreDataProperties.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/7/4.
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
    @NSManaged public var disabelJob: Bool
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var has: NSOrderedSet?

}

// MARK: Generated accessors for has
extension Job {

    @objc(insertObject:inHasAtIndex:)
    @NSManaged public func insertIntoHas(_ value: Task, at idx: Int)

    @objc(removeObjectFromHasAtIndex:)
    @NSManaged public func removeFromHas(at idx: Int)

    @objc(insertHas:atIndexes:)
    @NSManaged public func insertIntoHas(_ values: [Task], at indexes: NSIndexSet)

    @objc(removeHasAtIndexes:)
    @NSManaged public func removeFromHas(at indexes: NSIndexSet)

    @objc(replaceObjectInHasAtIndex:withObject:)
    @NSManaged public func replaceHas(at idx: Int, with value: Task)

    @objc(replaceHasAtIndexes:withHas:)
    @NSManaged public func replaceHas(at indexes: NSIndexSet, with values: [Task])

    @objc(addHasObject:)
    @NSManaged public func addToHas(_ value: Task)

    @objc(removeHasObject:)
    @NSManaged public func removeFromHas(_ value: Task)

    @objc(addHas:)
    @NSManaged public func addToHas(_ values: NSOrderedSet)

    @objc(removeHas:)
    @NSManaged public func removeFromHas(_ values: NSOrderedSet)

}
