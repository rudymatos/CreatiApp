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
    func createUser(displayName : String, username: String, password: String,  userType : LoginUser.userType)throws
    func deleteUser(username : String)throws
    func getAllBranchOfficesByDate(date: Date, authorized: Bool)throws -> [BranchOffice]
    func persistData()
    func createWinner(name: String, id: String?, email: String?, phone: String? ,nif: String?) -> Winner
    func getPrizes(forDate: Date, byBranchOffice : BranchOffice, forReport: Bool)throws -> [Prize]
    
}
