//
//  GenericDataReport.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/8/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation

class GenericDataReport{
    
    let branchOfficeName : String
    let branchOfficeAddress : String
    let branchOfficeImage : String
    let spanishDate: String
    
    init(branchOfficeName : String, branchOfficeAddress: String, branchOfficeImage: String, spanishDate: String){
        self.branchOfficeName = branchOfficeName
        self.branchOfficeAddress = branchOfficeAddress
        self.branchOfficeImage = branchOfficeImage
        self.spanishDate = spanishDate
    }
    
}
