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
    
    var originalVisit: Visit?
    var usingStockFromDifferrentBranchOffice : Bool = false
    var currentUser : LoginUser?
    var currentVisit : Visit?
    var currentUserPlaying : Winner?
    var currentPrize: Prize?
    
    
    func isFirstLaunch() -> Bool{
        if !UserDefaults.standard.bool(forKey: "isAppFirstLaunch"){
            UserDefaults.standard.set(true, forKey: "isAppFirstLaunch")
            UserDefaults.standard.synchronize()
            return true
        }
        return false
    }
    
    private init(){
        
    }
    
}
