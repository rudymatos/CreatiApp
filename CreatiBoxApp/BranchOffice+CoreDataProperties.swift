//
//  BranchOffice+CoreDataProperties.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData


extension BranchOffice {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BranchOffice> {
        return NSFetchRequest<BranchOffice>(entityName: "BranchOffice")
    }

    @NSManaged public var name: String?
    @NSManaged public var address: String?
    @NSManaged public var image: String?
    @NSManaged public var prizes: NSSet?

}

// MARK: Generated accessors for prizes
extension BranchOffice {

    @objc(addPrizesObject:)
    @NSManaged public func addToPrizes(_ value: Prize)

    @objc(removePrizesObject:)
    @NSManaged public func removeFromPrizes(_ value: Prize)

    @objc(addPrizes:)
    @NSManaged public func addToPrizes(_ values: NSSet)

    @objc(removePrizes:)
    @NSManaged public func removeFromPrizes(_ values: NSSet)

}
