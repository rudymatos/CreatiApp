//
//  Visit+CoreDataProperties.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/6/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData


extension Visit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Visit> {
        return NSFetchRequest<Visit>(entityName: "Visit")
    }

    @NSManaged public var date: NSDate
    @NSManaged public var authorized: Bool
    @NSManaged public var branchOffice: BranchOffice
    @NSManaged public var visitor: LoginUser
    @NSManaged public var prizes: NSSet

}

// MARK: Generated accessors for prizes
extension Visit {

    @objc(addPrizesObject:)
    @NSManaged public func addToPrizes(_ value: Prize)

    @objc(removePrizesObject:)
    @NSManaged public func removeFromPrizes(_ value: Prize)

    @objc(addPrizes:)
    @NSManaged public func addToPrizes(_ values: NSSet)

    @objc(removePrizes:)
    @NSManaged public func removeFromPrizes(_ values: NSSet)

}
