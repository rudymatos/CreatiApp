//
//  Prize+CoreDataProperties.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData


extension Prize {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Prize> {
        return NSFetchRequest<Prize>(entityName: "Prize")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var redeemed: Bool
    @NSManaged public var type: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var authorized: Bool
    @NSManaged public var branchOffice: BranchOffice?
    @NSManaged public var winner: Winner?
    @NSManaged public var authorizedBy: LoginUser?
    @NSManaged public var givenBy: LoginUser?

}
