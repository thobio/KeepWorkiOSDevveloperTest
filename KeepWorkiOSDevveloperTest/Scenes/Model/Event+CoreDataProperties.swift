//
//  Event+CoreDataProperties.swift
//  KeepWorkiOSDevveloperTest
//
//  Created by Thobio Joseph on 28/03/22.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var eventName: String?
    @NSManaged public var id: String?
    @NSManaged public var imageName: String?
    @NSManaged public var subTitle: String?
    @NSManaged public var type: Bool
    @NSManaged public var loc: String?
    @NSManaged public var tracking: Tracking?

}

extension Event : Identifiable {

}
