//
//  UIViewControllerExtension.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func getAppControl() -> AppControl{
        return AppControl.sharedInstance
    }
    
    func getCurrentBranchOfficeText() -> String{
        var branchOfficeName = "NO ENCONTRADO"
        if let branchOffice = getAppControl().currentBranchOffice{
         branchOfficeName = "\(branchOffice.name) \(branchOffice.address)"
        }
        return branchOfficeName
    }
    
    
    func logout(){
        getAppControl().currentBranchOffice = nil
        getAppControl().currentPrize = nil
        getAppControl().currentUser = nil
        getAppControl().currentUserPlaying = nil
    }
    
}
