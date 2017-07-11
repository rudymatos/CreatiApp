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
        
        case Sirena = "sirena"
        case Bravo = "bravo"
        case AU = "unidos"
        case Jumbo = "jumbo"
        case Player = "playero"
        case CienPorCiento = "100%"
        case Zaglul = "zaglul"
        case Iberia = "iberia"
        case Pola = "pola"
        case Nacional = "nacional"
        
        func getLogoImageName() -> String{
            return "logo_\(self.rawValue)"
        }
    }
    
    
}
