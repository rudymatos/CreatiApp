//
//  Prize+CoreDataProperties.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/6/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData


extension Prize {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Prize> {
        return NSFetchRequest<Prize>(entityName: "Prize")
    }

    @NSManaged public var name: String
    @NSManaged public var redeemed: Bool
    @NSManaged public var type: String
    @NSManaged public var givenBy: LoginUser?
    @NSManaged public var winner: Winner?
    @NSManaged public var visit: Visit?
    @NSManaged public var givenAt: BranchOffice?

}
