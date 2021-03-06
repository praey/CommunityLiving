//
//  Person+CoreDataProperties.swift
//  CommunityApp
//
//  Created by Tianyuan Zhang on 2018/7/4.
//  Copyright © 2018年 Javon Luke. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var emailAddress: String?
    @NSManaged public var jobIdCounter: Int32
    @NSManaged public var name: String?

}
