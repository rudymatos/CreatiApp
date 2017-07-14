//
//  InitialDataCreatorHelper.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 6/30/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation

public class InitialDataCreatorHelper{
    
    static let sharedInstance = InitialDataCreatorHelper()
    private let coreDataHelper = CoreDataHelper.sharedInstance
    private let dateHelper = DateHelper.sharedInstance
    
    private init(){
    }
    
    func regenerateStockForDays(username:String, date: String, restockItems: [Prize.PrizeType]){
        do{
            let supervisor = try coreDataHelper.getEntityByParam(fetchRequest: LoginUser.fetchRequest(), query: "username = %@", params: [username]).first!
            if let currentVisit = (supervisor.visits.allObjects as! [Visit]).filter({($0.date as Date) == dateHelper.getDateFromString(dateString: date)}).first{
                for prizeType in restockItems{
                    print("attempting to create prize \(prizeType.getSpanishVersion())")
                    let currentPrize = coreDataHelper.createPrize(name: prizeType.getSpanishVersion(), type: prizeType, branchOffice: currentVisit.branchOffice)
                    currentVisit.addToPrizes(currentPrize)
                    coreDataHelper.saveContext()
                }
            }
        }catch let error as NSError{
            print(error)
        }
    }
    
    func createInitialData(){
        if let schedulePath = Bundle.main.path(forResource: "oldpaso_schedule", ofType: "plist"), let dictionary = NSDictionary(contentsOfFile: schedulePath){
            for supervisorKey in dictionary.allKeys{
                let currentSupervisor = dictionary[supervisorKey] as! [String: Any]
                if let displayName = currentSupervisor["display_name"] as? String,let username = currentSupervisor["username"] as? String, let password = currentSupervisor["password"] as? String{
                    print("Creating Supervisor with following info:  display_name: \(displayName) - username: \(username) password: \(password)")
                    let supervisorObject = coreDataHelper.createLoginUser(displayName: displayName, username: username, password: password, userType: .supervisor, supervisor: nil)
                    if let promotionPerson = currentSupervisor["promotionPerson"] as? [String: Any]{
                        if let displayName = promotionPerson["display_name"] as? String,let username = promotionPerson["username"] as? String, let password = promotionPerson["password"] as? String{
                            print("Creating Promotion Person with following info:  display_name: \(displayName) - username: \(username) password: \(password)")
                            coreDataHelper.createLoginUser(displayName: displayName, username: username, password: password, userType: .promotionPerson, supervisor: supervisorObject)
                        }
                    }
                    
                    print("------------------")
                    print("Let's create some visits now, shall we? :)")
                    print("------------------")
                    
                    
                    if let visits = currentSupervisor["visits"] as? [[String:Any]]{
                        
                        for currentVisit in visits{
                            
                            if let dateString = currentVisit["visit_date"] as? String,
                                let branchOfficeName = currentVisit["branchoffice_name"] as? String,
                                let branchOfficeAddress = currentVisit["branchoffice_address"] as? String,
                                
                                let prizes = currentVisit["prizes"] as? [String]{
                                
                                let visitDate = dateHelper.getDateFromString(dateString: dateString)
                                var currentBranchOffice : BranchOffice?
                                
                                print("***************")
                                print("trying to look for branchoffice : \(branchOfficeName) \(branchOfficeAddress)")
                                let results = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: [branchOfficeName, branchOfficeAddress])
                                
                                if results.count == 0{
                                    print("not found, creating a new branch office \(branchOfficeName.lowercased())")
                                    let branchOfficeType = BranchOffice.BranchOfficeType(rawValue: branchOfficeName.lowercased())
                                    print("\(branchOfficeType!.getLogoImageName())")
                                    currentBranchOffice = coreDataHelper.createBranchOffice(name: branchOfficeName, address: branchOfficeAddress, image: branchOfficeType!.getLogoImageName())
                                }else{
                                    print("FOOOOOOOOUUUUNNNNDDDD")
                                    currentBranchOffice = results.first!
                                }
                                print("***************")
                                if let currentBranchOffice = currentBranchOffice{
                                    print("creating prizes now")
                                    var prizeList = [Prize]()
                                    for currentPrize in prizes{
                                        if let prizeType = Prize.PrizeType(rawValue: currentPrize){
                                            print("attempting to create prize \(prizeType.getSpanishVersion())")
                                            prizeList.append(coreDataHelper.createPrize(name: prizeType.getSpanishVersion(), type: prizeType, branchOffice: currentBranchOffice))
                                        }
                                    }
                                    print("creating visit")
                                    coreDataHelper.createVisit(date: visitDate, branchOffice: currentBranchOffice, visitor: supervisorObject, prizes: prizeList)
                                    print("created")
                                }
                            }
                        }
                    }
                    print("DONE")
                    print("------------------")
                    print()
                    
                }
            }
        }
    }
    
    
    
}
