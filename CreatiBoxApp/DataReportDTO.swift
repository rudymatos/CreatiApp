//
//  ScheduleReportDTO.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/7/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation

class DataReportDTO : GenericDataReport{
    
    let prizeCounter : [(name: String, quantity: Int)]
    
    init(branchOfficeName : String, branchOfficeAddress: String, branchOfficeImage: String, spanishDate: String, prizeCounter: [(name: String, quantity: Int)]){
        self.prizeCounter = prizeCounter
        super.init(branchOfficeName: branchOfficeName, branchOfficeAddress: branchOfficeAddress, branchOfficeImage: branchOfficeImage, spanishDate: spanishDate)
    }
    
}
