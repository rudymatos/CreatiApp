//
//  CoreDataHelper.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 6/30/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import UIKit
import CoreData

public class CoreDataHelper{
    
    static let sharedInstance = CoreDataHelper()
    fileprivate let dateHelper = DateHelper.sharedInstance
    fileprivate var managedObjectContext : NSManagedObjectContext!
    
    private init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        managedObjectContext = appDelegate.persistentContainer.viewContext
    }
    
    public func saveContext(){
        do{
            try managedObjectContext.save()
            managedObjectContext.refreshAllObjects()
        }catch let error as NSError{
            print(error)
        }
    }
    
    func createObjectContext(entityName : String) -> NSManagedObject{
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into: managedObjectContext)
    }
    
    func doesEntityExist<T : NSFetchRequestResult>(fetchRequest: NSFetchRequest<T>, query : String, params: [Any]?) -> Bool{
        var doesEntityExist = false
        let request : NSFetchRequest<T>  = fetchRequest
        request.predicate = NSPredicate(format: query, argumentArray: params)
        request.fetchLimit = 1
        do{
            if try managedObjectContext.fetch(request).count > 0{
                doesEntityExist = true
            }
        }catch{
        }
        return doesEntityExist
    }
    
    func getEntityByParam<T>(fetchRequest: NSFetchRequest<T>, query: String?, params : [Any]?)throws -> [T]{
        let request : NSFetchRequest<T> = fetchRequest
        if let query = query{
            if let params = params {
                request.predicate = NSPredicate(format: query, argumentArray: params)
            }else{
                request.predicate = NSPredicate(format: query)
            }
        }
        do{
            let results = try managedObjectContext.fetch(request)
            return results
        }catch{
            throw CoreDataExceptions.DataNotFound
        }
    }
    
    
    func getPrizes(forDate : Date, byBranchOffice: BranchOffice)throws -> [Prize]{
        
        let request : NSFetchRequest<Prize> = Prize.fetchRequest()
        let startDate = dateHelper.getStartOrEndDate(forDate: forDate)
        let endDate = dateHelper.getStartOrEndDate(forDate: forDate, start: false)
        
        if let branchName = byBranchOffice.name, let branchAddress = byBranchOffice.address{
            request.predicate = NSPredicate(format: "branchOffice.name = %@ and branchOffice.address = %@ and date >= %@ and date < %@", branchName, branchAddress, startDate, endDate)
            do{
                let results =  try managedObjectContext.fetch(request)
                if results.count > 0 {
                 return results
                }
                throw CoreDataExceptions.DataNotFound
            }catch{
                throw CoreDataExceptions.DataNotFound
            }
        }else{
            throw CoreDataExceptions.DataNotFound
        }
    }
    
    
    func getUserByUsernameAndPassword(username : String, password: String)throws -> LoginUser{
        let request : NSFetchRequest<LoginUser> = LoginUser.fetchRequest()
        request.predicate = NSPredicate(format: "username = %@ and password = %@", username, password)
        request.fetchLimit = 1
        do{
            let userResults = try managedObjectContext.fetch(request)
            if let currentUser = userResults.first{
                return currentUser
            }
        }catch {
        }
        throw LoginExceptions.InvalidUsernameOrPassword(message: "Usuario invalido. Favor verificar")
    }
    
    
}


//creation helper
extension CoreDataHelper{
    
    func createLoginUser(displayName: String, username: String, password: String, userType : LoginUser.userType){
        let loginUser = createObjectContext(entityName: LoginUser.className) as! LoginUser
        loginUser.username = username
        loginUser.displayName = displayName
        loginUser.type = userType.rawValue
        loginUser.password = password
        self.saveContext()
    }
    
    func createBranchOffice(name : String, address: String, image: String){
        let branchOffice = createObjectContext(entityName: BranchOffice.className) as! BranchOffice
        branchOffice.name = name
        branchOffice.address = address
        branchOffice.image = image
        self.saveContext()
    }
    
    func createWinner(name: String, id: String?, email: String?, phone: String?, nif : String?) -> Winner{
        let player = createObjectContext(entityName: Winner.className) as! Winner
        player.name = name
        player.email = email
        player.nif = nif
        player.phone = phone
        player.id = id
        self.saveContext()
        return player
    }
    
    func createPrize(name: String, type: Prize.PrizeType, date : Date = Date(), authorized: Bool = true, branchOffice : BranchOffice){
        let prize = createObjectContext(entityName: Prize.className) as! Prize
        prize.name = name
        prize.image = type.rawValue
        prize.type = type.rawValue
        prize.date = NSDate()
        prize.authorized = authorized
        prize.redeemed = false
        prize.branchOffice = branchOffice
        self.saveContext()
    }
    
    
    //method was created for the unitest
    func removeUserFromDB(username: String){
        let request : NSFetchRequest<LoginUser> = LoginUser.fetchRequest()
        request.predicate = NSPredicate(format: "username = %@", username)
        request.fetchLimit = 1
        do{
            if let currentUser = try managedObjectContext.fetch(request).first{
                managedObjectContext.delete(currentUser)
                saveContext()
            }
        }catch let error as NSError{
            print("Error deleting user with message : \(error.description)")
        }
    }
    
}

