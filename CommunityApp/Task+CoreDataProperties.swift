//
//  Task+CoreDataProperties.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/7/4.
//  Copyright © 2018年 Javon Luke. All rights reserved.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var audio: String?
    @NSManaged public var disableAudio: Bool
    @NSManaged public var disablePhoto: Bool
    @NSManaged public var disableTask: Bool
    @NSManaged public var disableText: Bool
    @NSManaged public var disableVideo: Bool
    @NSManaged public var id: String?
    @NSManaged public var photo: String?
    @NSManaged public var text: String?
    @NSManaged public var title: String?
    @NSManaged public var video: String?
    @NSManaged public var belongs: Job?
    @NSManaged public var has: NSOrderedSet?

}

// MARK: Generated accessors for has
extension Task {

    @objc(insertObject:inHasAtIndex:)
    @NSManaged public func insertIntoHas(_ value: Analytics, at idx: Int)

    @objc(removeObjectFromHasAtIndex:)
    @NSManaged public func removeFromHas(at idx: Int)

    @objc(insertHas:atIndexes:)
    @NSManaged public func insertIntoHas(_ values: [Analytics], at indexes: NSIndexSet)

    @objc(removeHasAtIndexes:)
    @NSManaged public func removeFromHas(at indexes: NSIndexSet)

    @objc(replaceObjectInHasAtIndex:withObject:)
    @NSManaged public func replaceHas(at idx: Int, with value: Analytics)

    @objc(replaceHasAtIndexes:withHas:)
    @NSManaged public func replaceHas(at indexes: NSIndexSet, with values: [Analytics])

    @objc(addHasObject:)
    @NSManaged public func addToHas(_ value: Analytics)

    @objc(removeHasObject:)
    @NSManaged public func removeFromHas(_ value: Analytics)

    @objc(addHas:)
    @NSManaged public func addToHas(_ values: NSOrderedSet)

    @objc(removeHas:)
    @NSManaged public func removeFromHas(_ values: NSOrderedSet)

}
