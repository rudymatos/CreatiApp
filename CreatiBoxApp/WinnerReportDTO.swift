//
//  PrizeReportDTO.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/8/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation

class WinnerReportDTO : GenericDataReport{
    
    let prizeName: String
    let prizeImage: String
    let winnerName: String
    let winnerId: String
    let winnerEmail : String
    let winnerPhone : String
    let givenBy: String
    let givenAt: String
    
    init(branchOfficeName : String, branchOfficeAddress: String, branchOfficeImage: String, spanishDate: String, prizeName : String, prizeImage: String, winnerName: String, winnerId: String, winnerEmail: String, winnerPhone: String, givenBy: String, givenAt: String){
        self.winnerName = winnerName
        self.winnerId  = winnerId
        self.winnerEmail = winnerEmail
        self.winnerPhone = winnerPhone
        self.prizeName = prizeName
        self.prizeImage = prizeImage
        self.givenAt = givenAt
        self.givenBy = givenBy
        super.init(branchOfficeName: branchOfficeName, branchOfficeAddress: branchOfficeAddress, branchOfficeImage: branchOfficeImage, spanishDate: spanishDate)
    }

}
