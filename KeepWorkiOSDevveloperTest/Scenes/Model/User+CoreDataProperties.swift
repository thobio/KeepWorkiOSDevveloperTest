//
//  User+CoreDataProperties.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 28/03/22.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?

}

extension User : Identifiable {

}
