//
//  CreatiBoxType.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation

protocol CreatiBoxType{
    
    func login(username: String, password: String)throws -> LoginUser
    func persistData()
    func doesVisitHaveAvailablePrizes(visit: Visit) -> Bool
    func getRandomPrizeFromVisit(visit: Visit)throws -> Prize
    func createWinner(name: String, id: String?, email: String?, phone: String? ,nif: String?) -> Winner
    func getVisit(forDate: Date, bySupervisor supervisor: LoginUser, nextAvailableVisit: Bool)throws -> Visit
    
}
