//
//  ManagedTransformer+CoreDataProperties.swift
//  
//
//  Created by Marco Parolin on 14/09/2019.
//
//

import Foundation
import CoreData

extension ManagedTransformer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ManagedTransformer> {
        return NSFetchRequest<ManagedTransformer>(entityName: "ManagedTransformer")
    }

    @NSManaged public var id: String
    @NSManaged public var name: String?
    @NSManaged public var team: String?
    @NSManaged public var team_icon: String?
    @NSManaged public var strength: Int16
    @NSManaged public var intelligence: Int16
    @NSManaged public var speed: Int16
    @NSManaged public var endurance: Int16
    @NSManaged public var rank: Int16
    @NSManaged public var courage: Int16
    @NSManaged public var firepower: Int16
    @NSManaged public var skill: Int16

}
