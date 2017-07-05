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
        coreDataHelper.createBranchOffice(name: "Pola", address: "Lopez de Vega", image: BranchOffice.BranchOfficeType.Pola.rawValue)
        coreDataHelper.createBranchOffice(name: "Jumbo", address: "Luperon", image: BranchOffice.BranchOfficeType.Jumbo.rawValue)
        coreDataHelper.createBranchOffice(name: "Nacional", address: "Bella Vista", image: BranchOffice.BranchOfficeType.Nacional.rawValue)
        coreDataHelper.createBranchOffice(name: "Sirena", address: "San Isidro", image: BranchOffice.BranchOfficeType.Sirena.rawValue)
    }
    
    
    func createPrizes(){
        if let branchOfficeJumbo = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["Jumbo", "Luperon"]).first{
            coreDataHelper.createPrize(name: "Prize1", type: .type1, authorized: false, branchOffice: branchOfficeJumbo)
            coreDataHelper.createPrize(name: "Prize1", type: .type2, authorized: true, branchOffice: branchOfficeJumbo)
            coreDataHelper.createPrize(name: "Prize1", type: .type3, authorized: true, branchOffice: branchOfficeJumbo)
            
        }
        
        if let branchOfficeSirena = try! coreDataHelper.getEntityByParam(fetchRequest: BranchOffice.fetchRequest(), query: "name = %@ and address = %@", params: ["Sirena", "San Isidro"]).first{
            coreDataHelper.createPrize(name: "Prize2", type: .type2, authorized: true, branchOffice: branchOfficeSirena)
        }
        
    }
    
    func createUserLoginData(){
        coreDataHelper.createLoginUser(displayName: "Juan Cordero", username: "jcordero", password: "12345", userType: .supervisor)
        coreDataHelper.createLoginUser(displayName: "Massiel Garcia", username: "mgarcia", password: "12345", userType: .promotionPerson)
    }
    
    
}
