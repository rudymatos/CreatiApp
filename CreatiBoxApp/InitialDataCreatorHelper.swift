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
    
    //TODO check if app is being opened for the first tiem
    func createBranchOffices(){
        //        coreDataHelper.createBranchOffice(name: "Bravo", address: "Winston Churchill", image: BranchOffice.BranchOfficeType.Bravo.getLogoImageName())
        //        coreDataHelper.createBranchOffice(name: "Jumbo", address: "Agora Mall", image: BranchOffice.BranchOfficeType.Jumbo.getLogoImageName())
        coreDataHelper.createBranchOffice(name: "La Sirena", address: "Wiston Churchill", image: BranchOffice.BranchOfficeType.LaSirena.getLogoImageName())
        coreDataHelper.createBranchOffice(name: "SM Nacional", address: "27 de Febrero", image: BranchOffice.BranchOfficeType.Nacional.getLogoImageName())
        coreDataHelper.createBranchOffice(name: "SM Pola", address: "Lope de Vega", image: BranchOffice.BranchOfficeType.Pola.getLogoImageName())
    }
    
    
    func createPrizes()throws{
        
        guard let nacinal27 = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["SM Nacional", "27 de Febrero"]).first else{
            throw CleanDataException.NoBranchOfficeFound
        }
        
        guard let polaLope = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["SM Pola", "Lope de Vega"]).first else{
            throw CleanDataException.NoBranchOfficeFound
        }
        
        //        guard let bravoChurchill = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["Bravo", "Wiston Churchill"]).first else{
        //            throw CleanDataException.NoBranchOfficeFound
        //        }
        //
        //
        guard let sirenaChurchill = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["La Sirena", "Wiston Churchill"]).first else{
            throw CleanDataException.NoBranchOfficeFound
        }
        //
        //        guard let jumboAgora = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["Jumbo", "Agora Mall"]).first else{
        //            throw CleanDataException.NoBranchOfficeFound
        //        }
        
        let supervisor1 = try! coreDataHelper.getEntityByParam(fetchRequest: LoginUser.fetchRequest(), query: "username = %@", params: ["supervisor1"]).first
        //        let supervisor2 = try! coreDataHelper.getEntityByParam(fetchRequest: LoginUser.fetchRequest(), query: "username = %@", params: ["supervisor2"]).first
        //        let supervisor3 = try! coreDataHelper.getEntityByParam(fetchRequest: LoginUser.fetchRequest(), query: "username = %@", params: ["supervisor3"]).first
        
        //            let prize1 = coreDataHelper.createPrize(name: "Cuchara", type: .spoon, branchOffice: boLaSirena)
        //            let prize2 = coreDataHelper.createPrize(name: "Guante", type: .kitchen_glove, branchOffice: boLaSirena)
        //            let prize3 = coreDataHelper.createPrize(name: "Envase Plastico", type: .plastic_container, branchOffice: boLaSirena)
        //            let prize4 = coreDataHelper.createPrize(name: "Lonchera", type: .lunch_box, branchOffice: boLaSirena)
        //            let prize5 = coreDataHelper.createPrize(name: "Kit Promocional", type: .promotional_kit, branchOffice: boLaSirena)
        //            coreDataHelper.createVisit(date: Date(), branchOffice: boLaSirena, visitor: supervisor1!, prizes: [prize1, prize2, prize3, prize4, prize5])
        //        }
        
        
        let prize111 = coreDataHelper.createPrize(name: "Cuchara", type: .spoon, branchOffice: sirenaChurchill)
        let prize211 = coreDataHelper.createPrize(name: "Guante", type: .kitchen_glove, branchOffice: sirenaChurchill)
        let prize311 = coreDataHelper.createPrize(name: "Envase Plastico", type: .plastic_container, branchOffice: sirenaChurchill)
        let prize411 = coreDataHelper.createPrize(name: "Lonchera", type: .lunch_box, branchOffice: sirenaChurchill)
        let prize511 = coreDataHelper.createPrize(name: "Kit Promocional", type: .promotional_kit, branchOffice: sirenaChurchill)
        coreDataHelper.createVisit(date: Date(), branchOffice: sirenaChurchill, visitor: supervisor1!, prizes: [prize111, prize211, prize311, prize411, prize511])
        
        
        
        let prize1 = coreDataHelper.createPrize(name: "Cuchara", type: .spoon, branchOffice: nacinal27)
        let prize2 = coreDataHelper.createPrize(name: "Guante", type: .kitchen_glove, branchOffice: nacinal27)
        let prize3 = coreDataHelper.createPrize(name: "Envase Plastico", type: .plastic_container, branchOffice: nacinal27)
        let prize4 = coreDataHelper.createPrize(name: "Lonchera", type: .lunch_box, branchOffice: nacinal27)
        let prize5 = coreDataHelper.createPrize(name: "Kit Promocional", type: .promotional_kit, branchOffice: nacinal27)
        coreDataHelper.createVisit(date: dateHelper.getTomorrowsDate(), branchOffice: nacinal27, visitor: supervisor1!, prizes: [prize1, prize2, prize3, prize4, prize5])
        
        
        
        let prize11 = coreDataHelper.createPrize(name: "Cuchara", type: .spoon, branchOffice: polaLope)
        let prize21 = coreDataHelper.createPrize(name: "Guante", type: .kitchen_glove, branchOffice: polaLope)
        let prize31 = coreDataHelper.createPrize(name: "Envase Plastico", type: .plastic_container, branchOffice: polaLope)
        let prize41 = coreDataHelper.createPrize(name: "Lonchera", type: .lunch_box, branchOffice: polaLope)
        let prize51 = coreDataHelper.createPrize(name: "Kit Promocional", type: .promotional_kit, branchOffice: polaLope)
        coreDataHelper.createVisit(date: dateHelper.getDateFromString(dateString: "07/10/2017"), branchOffice: polaLope, visitor: supervisor1!, prizes: [prize11, prize21, prize31, prize41, prize51])
        
        
        
        
        //        if let boBravo = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["Bravo", "Wiston Churchill"]).first{
        //            let supervisor2 = try! coreDataHelper.getEntityByParam(fetchRequest: LoginUser.fetchRequest(), query: "username = %@", params: ["supervisor2"]).first
        //            let prize1 = coreDataHelper.createPrize(name: "Cuchara", type: .spoon, branchOffice: boBravo)
        //            let prize2 = coreDataHelper.createPrize(name: "Guante", type: .kitchen_glove, branchOffice: boBravo)
        //            let prize3 = coreDataHelper.createPrize(name: "Envase Plastico", type: .plastic_container, branchOffice: boBravo)
        //            let prize4 = coreDataHelper.createPrize(name: "Lonchera", type: .lunch_box, branchOffice: boBravo)
        //            let prize5 = coreDataHelper.createPrize(name: "Kit Promocional", type: .promotional_kit, branchOffice: boBravo)
        //            coreDataHelper.createVisit(date: Date(), branchOffice: boBravo, visitor: supervisor2!, prizes: [prize1, prize2, prize3, prize4, prize5])
        //        }
        //
        //        if let boJumbo = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["Jumbo", "Agora Mall"]).first{
        //            let supervisor3 = try! coreDataHelper.getEntityByParam(fetchRequest: LoginUser.fetchRequest(), query: "username = %@", params: ["supervisor3"]).first
        //            let prize1 = coreDataHelper.createPrize(name: "Cuchara", type: .spoon, branchOffice: boJumbo)
        //            let prize2 = coreDataHelper.createPrize(name: "Guante", type: .kitchen_glove, branchOffice: boJumbo)
        //            let prize3 = coreDataHelper.createPrize(name: "Envase Plastico", type: .plastic_container, branchOffice: boJumbo)
        //            let prize4 = coreDataHelper.createPrize(name: "Lonchera", type: .lunch_box, branchOffice: boJumbo)
        //            let prize5 = coreDataHelper.createPrize(name: "Kit Promocional", type: .promotional_kit, branchOffice: boJumbo)
        //            coreDataHelper.createVisit(date: Date(), branchOffice: boJumbo, visitor: supervisor3!, prizes: [prize1, prize2, prize3, prize4, prize5])
        //        }
        
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
