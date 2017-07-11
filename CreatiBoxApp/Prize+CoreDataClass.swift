//
//  Prize+CoreDataClass.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/6/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation
import CoreData
import UIKit

@objc(Prize)
public class Prize: NSManagedObject {
    
    static let className = "Prize"
    
    enum PrizeType : String{
        case spoon = "prize_spoon"
        case kitchen_glove = "prize_kitchen_gloves"
        case plastic_container = "prize_plastic_container"
        case lunch_box = "prize_lunch_box"
        case promotional_kit = "prize_promotional_kit"
        
        
        func getSpanishVersion() -> String{
            switch self {
            case .spoon:
                return "Cuchara"
            case .kitchen_glove:
                return "Guantes"
            case .lunch_box:
                return "Lonchera"
            case .plastic_container:
                return "Envase Plastico"
            case .promotional_kit:
                return "Kit Promocional"
            }
        }
    }
    
    static func getAllPrizeTypes() -> [PrizeType]{
        return [.spoon, .kitchen_glove, .plastic_container, .lunch_box, .promotional_kit]
    }
    
    func getImage() -> UIImage{
        return UIImage(named: type) ?? UIImage(named: "no_image_found_for_prize")!
    }
    
    
}
