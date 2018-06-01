//
//  Person+CoreDataProperties.swift
//  CommunityApp
//
//  Created by Javon Luke on 2018-05-26.
//  Copyright © 2018 Javon Luke. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var email: String?

}
