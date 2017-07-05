//
//  BranchOffice+CoreDataClass.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData

@objc(BranchOffice)
public class BranchOffice: NSManagedObject {

    static let className = "BranchOffice"
    
    enum BranchOfficeType: String{
        case Sirena = "sirena"
        case Nacional = "nacional"
        case Jumbo = "jumbo"
        case Pola = "pola"
        case Bravo = "bravo"
    }
    
}