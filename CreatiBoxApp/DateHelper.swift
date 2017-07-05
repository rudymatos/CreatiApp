//
//  DateHelper.swift
//  CreatiBoxApp
//
//  Created by Rudy E Matos on 7/1/17.
//  Copyright © 2017 Bearded Gentleman. All rights reserved.
//

import Foundation

class DateHelper{
    
    static let sharedInstance = DateHelper()
    
    private init(){
        
    }
    
    func getStartOrEndDate(forDate : Date = Date(), start : Bool = true) -> NSDate{
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let date = calendar.startOfDay(for: forDate)
        
        if start{
            return date as NSDate
        }
        
        var component = calendar.dateComponents([.year, .month, .day, .minute, .second], from: date)
        component.day! += 1
        return calendar.date(from: component)! as NSDate
    }
    
    
}
