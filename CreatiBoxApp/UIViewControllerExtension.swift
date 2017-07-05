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
    
    func logout(){
        getAppControl().branchOfficeList = nil
        getAppControl().currentBranchOffice = nil
        getAppControl().currentPrize = nil
        getAppControl().currentUser = nil
        getAppControl().currentUserPlaying = nil
    }
    
}
