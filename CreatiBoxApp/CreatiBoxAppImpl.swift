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
    
    private func getSortedVisits(bySupervisor supervisor : LoginUser) -> [Visit]{
        return (supervisor.visits.allObjects as! [Visit]).sorted(by: {($0.date as Date) < ($1.date as Date)})
    }
    
    func doesVisitHaveAvailablePrizes(visit: Visit) -> Bool{
        return (visit.prizes.allObjects as! [Prize]).filter({!$0.redeemed}).count > 0
    }
    
    func getAvailablePrizes(fromVisit: Visit) -> [Prize]{
        return (fromVisit.prizes.allObjects as! [Prize]).filter({!$0.redeemed})
    }
    
    
    func getVisit(forDate: Date = Date(), bySupervisor supervisor: LoginUser, nextAvailableVisit: Bool = false)throws -> Visit{
        let sortedVisit = getSortedVisits(bySupervisor: supervisor)
        if let index = sortedVisit.index(where: { (currentVisit) -> Bool in
            let startDate = dateHelper.getStartOrEndDate(forDate: forDate)
            let endDate = dateHelper.getStartOrEndDate(forDate: forDate, start: false)
            let visitDate = (currentVisit.date as Date)
            return visitDate >= startDate && visitDate < endDate
        }){
            if nextAvailableVisit{
                if (index + 1) <= (sortedVisit.count - 1){
                    return sortedVisit[(index + 1)]
                }else{
                    throw CleanDataException.NoAvailableVisits
                }
            }
            return sortedVisit[index]
        }else{
            throw CleanDataException.NoAvailableVisits
        }
    }
    
    
    func getRandomPrizeFromVisit(visit: Visit)throws -> Prize{
        if doesVisitHaveAvailablePrizes(visit: visit){
            let availablePrizes = getAvailablePrizes(fromVisit: visit)
            let randomIndex = arc4random_uniform(UInt32(availablePrizes.count))
            return availablePrizes[Int(randomIndex)]
        }else{
            throw CleanDataException.NoPrizeFound
        }
    }
    
    
    func persistData(){
        coreDataHelper.saveContext()
    }
    
    func createWinner(name: String, id: String?, email: String?, phone: String? ,nif: String?) -> Winner{
        return coreDataHelper.createWinner(name: name, id: id, email: email, phone: phone, nif: nif)
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
