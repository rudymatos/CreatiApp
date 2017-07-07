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
    
    private init(){
        
    }
    
    //TODO check if app is being opened for the first tiem
    func createBranchOffices(){
        coreDataHelper.createBranchOffice(name: "Bravo", address: "Winston Churchill", image: BranchOffice.BranchOfficeType.Bravo.rawValue)
        coreDataHelper.createBranchOffice(name: "Jumbo", address: "Agora Mall", image: BranchOffice.BranchOfficeType.Jumbo.rawValue)
        coreDataHelper.createBranchOffice(name: "La Sirena", address: "Wiston Churchill", image: BranchOffice.BranchOfficeType.LaSirena.rawValue)
    }
    
    
    func createPrizes(){
        if let boLaSirena = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["La Sirena", "Wiston Churchill"]).first{
            let supervisor1 = try! coreDataHelper.getEntityByParam(fetchRequest: LoginUser.fetchRequest(), query: "username = %@", params: ["supervisor1"]).first
            let prize1 = coreDataHelper.createPrize(name: "Cuchara", type: .spoon, branchOffice: boLaSirena)
            let prize2 = coreDataHelper.createPrize(name: "Guante", type: .kitchen_glove, branchOffice: boLaSirena)
            let prize3 = coreDataHelper.createPrize(name: "Envase Plastico", type: .plastic_container, branchOffice: boLaSirena)
            let prize4 = coreDataHelper.createPrize(name: "Lonchera", type: .lunch_box, branchOffice: boLaSirena)
            let prize5 = coreDataHelper.createPrize(name: "Kit Promocional", type: .promotional_kit, branchOffice: boLaSirena)
            coreDataHelper.createVisit(date: Date(), branchOffice: boLaSirena, visitor: supervisor1!, prizes: [prize1, prize2, prize3, prize4, prize5])
        }
        
        if let boBravo = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["Bravo", "Wiston Churchill"]).first{
            let supervisor2 = try! coreDataHelper.getEntityByParam(fetchRequest: LoginUser.fetchRequest(), query: "username = %@", params: ["supervisor2"]).first
            let prize1 = coreDataHelper.createPrize(name: "Cuchara", type: .spoon, branchOffice: boBravo)
            let prize2 = coreDataHelper.createPrize(name: "Guante", type: .kitchen_glove, branchOffice: boBravo)
            let prize3 = coreDataHelper.createPrize(name: "Envase Plastico", type: .plastic_container, branchOffice: boBravo)
            let prize4 = coreDataHelper.createPrize(name: "Lonchera", type: .lunch_box, branchOffice: boBravo)
            let prize5 = coreDataHelper.createPrize(name: "Kit Promocional", type: .promotional_kit, branchOffice: boBravo)
            coreDataHelper.createVisit(date: Date(), branchOffice: boBravo, visitor: supervisor2!, prizes: [prize1, prize2, prize3, prize4, prize5])
        }
        
        if let boJumbo = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["Jumbo", "Agora Mall"]).first{
            let supervisor3 = try! coreDataHelper.getEntityByParam(fetchRequest: LoginUser.fetchRequest(), query: "username = %@", params: ["supervisor3"]).first
            let prize1 = coreDataHelper.createPrize(name: "Cuchara", type: .spoon, branchOffice: boJumbo)
            let prize2 = coreDataHelper.createPrize(name: "Guante", type: .kitchen_glove, branchOffice: boJumbo)
            let prize3 = coreDataHelper.createPrize(name: "Envase Plastico", type: .plastic_container, branchOffice: boJumbo)
            let prize4 = coreDataHelper.createPrize(name: "Lonchera", type: .lunch_box, branchOffice: boJumbo)
            let prize5 = coreDataHelper.createPrize(name: "Kit Promocional", type: .promotional_kit, branchOffice: boJumbo)
            coreDataHelper.createVisit(date: Date(), branchOffice: boJumbo, visitor: supervisor3!, prizes: [prize1, prize2, prize3, prize4, prize5])
        }
        
    }
    
    func createUserLoginData(){
        let supervisor1 = coreDataHelper.createLoginUser(displayName: "Supervisor1", username: "supervisor1", password: "12345", userType: .supervisor, supervisor: nil)
        let supervisor2 = coreDataHelper.createLoginUser(displayName: "Supervisor2", username: "supervisor2", password: "12345", userType: .supervisor, supervisor: nil)
        let supervisor3 = coreDataHelper.createLoginUser(displayName: "Supervisor3", username: "supervisor3", password: "12345", userType: .supervisor, supervisor: nil)
        coreDataHelper.createLoginUser(displayName: "Promotor/a", username: "promotor1", password: "12345", userType: .promotionPerson, supervisor: supervisor1)
        coreDataHelper.createLoginUser(displayName: "Promotor/a", username: "promotor2", password: "12345", userType: .promotionPerson, supervisor: supervisor2)
        coreDataHelper.createLoginUser(displayName: "Promotor/a", username: "promotor3", password: "12345", userType: .promotionPerson, supervisor: supervisor3)
    }
    
    
}
