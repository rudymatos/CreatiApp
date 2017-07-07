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
        case kitchen_glove = "prize_kitchen"
        case plastic_container = "prize_plastic_container"
        case lunch_box = "prize_lunch_box"
        case promotional_kit = "prize_promotional_kit"
    }
    
    func getImage() -> UIImage{
        return UIImage(named: type) ?? UIImage(named: "no_image_found_for_prize")!
    }
    
    
    
}
