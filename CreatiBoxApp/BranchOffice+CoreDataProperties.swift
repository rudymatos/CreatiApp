//
//  BranchOffice+CoreDataProperties.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/6/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData


extension BranchOffice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BranchOffice> {
        return NSFetchRequest<BranchOffice>(entityName: "BranchOffice")
    }

    @NSManaged public var address: String
    @NSManaged public var image: String
    @NSManaged public var name: String
    @NSManaged public var visits: NSSet
    @NSManaged public var givenPrizes: NSSet?

}

// MARK: Generated accessors for visits
extension BranchOffice {

    @objc(addVisitsObject:)
    @NSManaged public func addToVisits(_ value: Visit)

    @objc(removeVisitsObject:)
    @NSManaged public func removeFromVisits(_ value: Visit)

    @objc(addVisits:)
    @NSManaged public func addToVisits(_ values: NSSet)

    @objc(removeVisits:)
    @NSManaged public func removeFromVisits(_ values: NSSet)

}

// MARK: Generated accessors for givenPrizes
extension BranchOffice {

    @objc(addGivenPrizesObject:)
    @NSManaged public func addToGivenPrizes(_ value: Prize)

    @objc(removeGivenPrizesObject:)
    @NSManaged public func removeFromGivenPrizes(_ value: Prize)

    @objc(addGivenPrizes:)
    @NSManaged public func addToGivenPrizes(_ values: NSSet)

    @objc(removeGivenPrizes:)
    @NSManaged public func removeFromGivenPrizes(_ values: NSSet)

}
