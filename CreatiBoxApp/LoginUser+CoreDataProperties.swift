//
//  LoginUser+CoreDataProperties.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData


extension LoginUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LoginUser> {
        return NSFetchRequest<LoginUser>(entityName: "LoginUser")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var password: String?
    @NSManaged public var type: String?
    @NSManaged public var username: String?
    @NSManaged public var authorizedPrizes: NSSet?
    @NSManaged public var givenPrizes: NSSet?

}

// MARK: Generated accessors for authorizedPrizes
extension LoginUser {

    @objc(addAuthorizedPrizesObject:)
    @NSManaged public func addToAuthorizedPrizes(_ value: Prize)

    @objc(removeAuthorizedPrizesObject:)
    @NSManaged public func removeFromAuthorizedPrizes(_ value: Prize)

    @objc(addAuthorizedPrizes:)
    @NSManaged public func addToAuthorizedPrizes(_ values: NSSet)

    @objc(removeAuthorizedPrizes:)
    @NSManaged public func removeFromAuthorizedPrizes(_ values: NSSet)

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
