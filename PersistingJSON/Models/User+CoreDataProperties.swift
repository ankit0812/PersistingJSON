//
//  User+CoreDataProperties.swift
//  PersistingJSON
//
//  Created by KingpiN on 17/07/19.
//  Copyright © 2019 KingpiN. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String
    @NSManaged public var age: Int16
    @NSManaged public var id: Int16

}
