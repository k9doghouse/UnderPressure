//
//  Entity+CoreDataProperties.swift
//  UnderPressure
//
//  Created by murph on 4/22/19.
//  Copyright © 2019 k9doghouse. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        
        return NSFetchRequest<Entity>(entityName: "Entity")
    }

    @NSManaged public var texttitle: String?

}
