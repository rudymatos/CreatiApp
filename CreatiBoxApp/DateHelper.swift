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
    private var calendar = Calendar.current
    private var componentsSet = Set<Calendar.Component>()
    
    private init(){
        calendar.timeZone = TimeZone.current
        componentsSet = [.year, .month, .day, .minute, .second, .weekday]
    }
    
    func getStartOrEndDate(forDate : Date = Date(), start : Bool = true) -> Date{
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let date = calendar.startOfDay(for: forDate)
        if start{
            return date
        }
        var component = calendar.dateComponents(componentsSet, from: date)
        component.day! += 1
        return calendar.date(from: component)!
    }
    
    
    func getTomorrowsDate(fromDate : Date = Date()) -> Date{
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        let currentDate = calendar.startOfDay(for: fromDate)
        var components = calendar.dateComponents(componentsSet, from: currentDate)
        components.day! += 1
        return calendar.date(from: components)!
    }
    
    func getDateString(fromDate: Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.string(from:fromDate)
    }
    
    func getSpanishReadeableDate(fromDate: Date) -> String{
        var components = calendar.dateComponents(componentsSet, from: fromDate)
        let monthString = getSpanishMonth(month: components.month ?? 1)
        let dayString = getSpanishDay(day: components.weekday ?? 1)
        let day = components.day
        let year = components.year
        return "\(dayString) \(day ?? 1) de \(monthString) del \(year ?? 2222)"
    }
    
    private func getSpanishDay(day: Int) -> String{
        return ["Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado"][day - 1]
        
    }
    
    private func getSpanishMonth(month: Int) -> String{
        return ["Enero","Febrero", "Marzo","Abril","Mayo","Junio","Julio","Agosto","Septiembre","Octubre","Noviembre","Diciembre"][month - 1]
    }
    
    
    func getDateFromString(dateString : String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        return dateFormatter.date(from: dateString)!
    }
    
}
