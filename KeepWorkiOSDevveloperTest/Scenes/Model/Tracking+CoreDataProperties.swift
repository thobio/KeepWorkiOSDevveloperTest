//
//  Tracking+CoreDataProperties.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 28/03/22.
//
//

import Foundation
import CoreData


extension Tracking {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tracking> {
        return NSFetchRequest<Tracking>(entityName: "Tracking")
    }

    @NSManaged public var trackingId: String?
    @NSManaged public var userId: String?
    @NSManaged public var event: NSSet?

}

// MARK: Generated accessors for event
extension Tracking {

    @objc(addEventObject:)
    @NSManaged public func addToEvent(_ value: Event)

    @objc(removeEventObject:)
    @NSManaged public func removeFromEvent(_ value: Event)

    @objc(addEvent:)
    @NSManaged public func addToEvent(_ values: NSSet)

    @objc(removeEvent:)
    @NSManaged public func removeFromEvent(_ values: NSSet)

}

extension Tracking : Identifiable {

}
