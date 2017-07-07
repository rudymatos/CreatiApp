//
//  AppControl.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation

class AppControl{
    
    static let sharedInstance = AppControl()
    
    var currentUser : LoginUser?
    var currentBranchOffice : BranchOffice?
    var currentUserPlaying : Winner?
    var currentPrize: Prize?
    
    private init(){
        
    }
    
}
