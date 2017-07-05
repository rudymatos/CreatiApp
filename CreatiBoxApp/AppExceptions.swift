//
//  AppExceptions.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 6/30/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation


enum CoreDataExceptions : Error{
    
    case DataNotFound
    
}


enum CleanDataException: Error{
    
    case NoBranchOfficeFound
    case NoPrizeFound
    case InvalidData(message : String)
    
    
}

enum LoginExceptions: Error{
    
    case InvalidUsernameOrPassword(message : String?)
    case UserAlreadyExists
    case UserDoesntExist
    case GenericException(message : String?)
    
}
