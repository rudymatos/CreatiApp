//
//  LoginUser+CoreDataClass.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 6/30/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData


public class LoginUser: NSManagedObject {
    
    static let className = "LoginUser"
    
    enum userType : String{
        case promotionPerson = "promitionPerson"
        case supervisor = "supervisor"
    }
    
}
