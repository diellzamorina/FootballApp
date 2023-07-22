//
//  Player+CoreDataProperties.swift
//  
//
//  Created by Student on 8.6.23.
//
//

import Foundation
import CoreData


extension Player {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Player> {
        return NSFetchRequest<Player>(entityName: "Player")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16
    @NSManaged public var position: String?

}
