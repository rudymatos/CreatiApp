//
//  Winner+CoreDataProperties.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData


extension Winner {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Winner> {
        return NSFetchRequest<Winner>(entityName: "Winner")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: String?
    @NSManaged public var phone: String?
    @NSManaged public var email: String?
    @NSManaged public var nif: String?
    @NSManaged public var prizes: NSSet?

}

// MARK: Generated accessors for prizes
extension Winner {

    @objc(addPrizesObject:)
    @NSManaged public func addToPrizes(_ value: Prize)

    @objc(removePrizesObject:)
    @NSManaged public func removeFromPrizes(_ value: Prize)

    @objc(addPrizes:)
    @NSManaged public func addToPrizes(_ values: NSSet)

    @objc(removePrizes:)
    @NSManaged public func removeFromPrizes(_ values: NSSet)

}
