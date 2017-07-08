//
//  BranchOffice+CoreDataClass.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/6/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData

@objc(BranchOffice)
public class BranchOffice: NSManagedObject {

    static let className = "BranchOffice"
    
    enum BranchOfficeType : String{
        
        case LaSirena = "lasirena"
        case Bravo = "bravo"
        case Jumbo = "jumbo"
        case Pola = "pola"
        case Nacional = "nacional"
        
        func getLogoImageName() -> String{
            return "logo_\(self.rawValue)"
        }
    }
    
    
}
