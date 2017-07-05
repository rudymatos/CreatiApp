//
//  Prize+CoreDataClass.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData

@objc(Prize)
public class Prize: NSManagedObject {

    static let className = "Prize"
    
    enum PrizeType: String{
        case type1 = "type1"
        case type2 = "type2"
        case type3 = "type3"
    }
    
    
}
