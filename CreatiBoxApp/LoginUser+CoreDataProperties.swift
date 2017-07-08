//
//  LoginUser+CoreDataProperties.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/6/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData


extension LoginUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginUser> {
        return NSFetchRequest<LoginUser>(entityName: "LoginUser")
    }

    @NSManaged public var displayName: String
    @NSManaged public var password: String
    @NSManaged public var type: String
    @NSManaged public var username: String
    @NSManaged public var givenPrizes: NSSet?
    @NSManaged public var supervisor: LoginUser?
    @NSManaged public var visits: NSSet

}

// MARK: Generated accessors for givenPrizes
extension LoginUser {

    @objc(addGivenPrizesObject:)
    @NSManaged public func addToGivenPrizes(_ value: Prize)

    @objc(removeGivenPrizesObject:)
    @NSManaged public func removeFromGivenPrizes(_ value: Prize)

    @objc(addGivenPrizes:)
    @NSManaged public func addToGivenPrizes(_ values: NSSet)

    @objc(removeGivenPrizes:)
    @NSManaged public func removeFromGivenPrizes(_ values: NSSet)

}

// MARK: Generated accessors for visits
extension LoginUser {

    @objc(addVisitsObject:)
    @NSManaged public func addToVisits(_ value: Visit)

    @objc(removeVisitsObject:)
    @NSManaged public func removeFromVisits(_ value: Visit)

    @objc(addVisits:)
    @NSManaged public func addToVisits(_ values: NSSet)

    @objc(removeVisits:)
    @NSManaged public func removeFromVisits(_ values: NSSet)

}
