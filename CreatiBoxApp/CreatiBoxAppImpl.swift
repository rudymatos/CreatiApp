//
//  CreatiBoxAppImpl.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation

class CreatiBoxAppImpl : CreatiBoxType{
    
    private let coreDataHelper = CoreDataHelper.sharedInstance
    private let dateHelper = DateHelper.sharedInstance
    
    func createUser(displayName : String, username: String, password: String,  userType : LoginUser.userType)throws{
        if coreDataHelper.doesEntityExist(fetchRequest: LoginUser.fetchRequest(), query: "username = %@", params: [username]){
            throw LoginExceptions.UserAlreadyExists
        }
        coreDataHelper.createLoginUser(displayName: displayName, username: username, password: password, userType: userType)
    }
    
    func getPrizes(forDate: Date, byBranchOffice : BranchOffice, forReport: Bool = false)throws -> [Prize]{
        if let bOName = byBranchOffice.name, let bOAddress = byBranchOffice.address{
            let startDate = dateHelper.getStartOrEndDate(forDate: Date())
            let endDate = dateHelper.getStartOrEndDate(forDate: Date(), start: false)
            
            let availablePrizesForToday = try coreDataHelper.getEntityByParam(fetchRequest: Prize.fetchRequest(), query: "branchOffice.name = %@ and branchOffice.address = %@ and date >= %@ and date < %@ \(!forReport ? "and authorized = YES and redeemed = NO" : "")", params: [bOName, bOAddress,startDate,endDate])
            
            return availablePrizesForToday
        }
        throw CleanDataException.InvalidData(message: "Data Invalida. Sucursal sin nombre o sin Direccion")
        
    }
    
    func selectedRandomPrizeFromBranchOffice(branchOffice : BranchOffice)throws -> Prize{
        do{
            let availablePrizesForToday = try getPrizes(forDate: Date(), byBranchOffice: branchOffice)
            let totalAvailablePrizes = availablePrizesForToday.count
            if availablePrizesForToday.count <= 0 {
                throw CleanDataException.NoPrizeFound
            }
            let randomIndex = arc4random_uniform(UInt32(totalAvailablePrizes))
            return availablePrizesForToday[Int(randomIndex)]
            
        }catch CoreDataExceptions.DataNotFound{
            throw CleanDataException.NoPrizeFound
        }
    }
    
    
    func getAllBranchOfficesByDate(date: Date, authorized: Bool)throws -> [BranchOffice]{
        
        let fromDate = dateHelper.getStartOrEndDate()
        let toDate = dateHelper.getStartOrEndDate(start: false)
        let queryString = "SUBQUERY(prizes, $p, any $p.date >= %@ and $p.date < %@ and $p.redeemed == NO \(authorized ? "and $p.authorized == YES" : "")).@count > 0"
        let branchOfficeList = try coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: queryString, params: [fromDate, toDate]) as [BranchOffice]
        if branchOfficeList.count > 0 {
            return branchOfficeList
        }
        throw CleanDataException.NoBranchOfficeFound
    }
    
    
    func persistData(){
        coreDataHelper.saveContext()
    }
    
    func createWinner(name: String, id: String?, email: String?, phone: String? ,nif: String?) -> Winner{
        return coreDataHelper.createWinner(name: name, id: id, email: email, phone: phone, nif: nif)
    }
    
    func deleteUser(username : String)throws{
        if !coreDataHelper.doesEntityExist(fetchRequest: LoginUser.fetchRequest(), query: "username = %@", params: [username]){
            throw LoginExceptions.UserDoesntExist
        }
        coreDataHelper.removeUserFromDB(username: username)
        
    }
    
    func login(username: String, password: String)throws -> LoginUser {
        do{
            let loginUser = try coreDataHelper.getUserByUsernameAndPassword(username: username, password: password)
            return loginUser
        }catch LoginExceptions.InvalidUsernameOrPassword (let message){
            throw LoginExceptions.InvalidUsernameOrPassword(message: message)
        }catch let error as NSError{
            throw LoginExceptions.GenericException(message: "Exception : \(error.description). Favor contacte al adminitrador")
        }
        
    }
    
    
}
