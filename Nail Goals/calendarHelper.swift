//
//  calendarHelper.swift
//  Nail Goals
//
//  Created by Sparty on 5/13/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import Foundation
import UIKit

extension NSDate {
    func xYears(x:Int, startDate: NSDate)       -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitYear,        value: x, toDate: startDate, options: nil)!
    }
    func xQuarters(x:Int, startDate: NSDate)    -> NSDate {
        return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitQuarter,     value: x, toDate: startDate, options: nil)!
    }
    func xMonths(x:Int, startDate: NSDate)      -> NSDate { return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitMonth,       value: x, toDate: startDate, options: nil)! }
    func xWeeks(x:Int, startDate: NSDate)       -> NSDate { return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitWeekOfYear,  value: x, toDate: startDate, options: nil)! }
    func xDays(x:Int, startDate: NSDate)        -> NSDate { return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitDay,         value: x, toDate: startDate, options: nil)! }
    func xHours(x:Int, startDate: NSDate)       -> NSDate { return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitHour,        value: x, toDate: startDate, options: nil)! }
    func xMinutes(x:Int, startDate: NSDate)     -> NSDate { return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitMinute,      value: x, toDate: startDate, options: nil)! }
    func xSeconds(x:Int, startDate: NSDate)     -> NSDate { return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitSecond,      value: x, toDate: startDate, options: nil)! }
    func xNanoseconds(x:Int, startDate: NSDate) -> NSDate { return NSCalendar.currentCalendar().dateByAddingUnit(.CalendarUnitNanosecond,  value: x, toDate: startDate, options: nil)! }
}

struct calenderObject {
    
    func calculateDay(x: Int, stDt: NSDate) -> Array<Int>{
        //var calDayMonthYr = Dictionary<String, Int>()
        
        NSDate().xYears(x, startDate:stDt)  // "Jan 5, 2017, 8:03 PM"
        NSDate().xMonths(x, startDate:stDt) // "Mar 5, 2015, 8:03 PM"
        var day = NSDate().xDays(x, startDate:stDt)   // "Jan 7, 2015, 8:03 PM"
        let flags: NSCalendarUnit = (NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitWeekday)
        var components = NSCalendar.currentCalendar().components(flags, fromDate: day)
        var calDayMonthYr: [Int] = [components.month, components.day, components.year, components.weekday  ]
        //calDayMonthYr = ["Year": components.year , "Month": components.month , "Day": components.day ]
        
        
        
        return calDayMonthYr
    }
    func calweekDayFromDate(date: NSDate) ->Array<Int>{
        
        
        let flags: NSCalendarUnit = (NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear | NSCalendarUnit.CalendarUnitWeekday)
        var components = NSCalendar.currentCalendar().components(flags, fromDate: date)
        var calDayMonthYr: [Int] = [components.month, components.day, components.year, components.weekday  ]
        //calDayMonthYr = ["Year": components.year , "Month": components.month , "Day": components.day ]
        
        
        
        return calDayMonthYr
    }
    
}


