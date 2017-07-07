//
//  LoginUser+CoreDataClass.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/6/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData


public class LoginUser: NSManagedObject {

    static let className = "LoginUser"
 
    enum UserType : String {
        case supervisor = "supervisor"
        case promotionPerson = "promotion_girl"
        
        
        func isSupervisor() -> Bool{
            return self == UserType.supervisor
        }
        
    }
    
}
