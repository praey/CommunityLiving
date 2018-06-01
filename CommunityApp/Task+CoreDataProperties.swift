//
//  Task+CoreDataProperties.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/5/23.
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
    @NSManaged public var jobid: String?
    @NSManaged public var photo: String?
    @NSManaged public var text: String?
    @NSManaged public var video: String?
    @NSManaged public var title: String?
    @NSManaged var analytics: Analytics?
    @NSManaged public var belongs: Job?

}
