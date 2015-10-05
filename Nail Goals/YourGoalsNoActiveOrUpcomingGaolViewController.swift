//
//  YourGoalsNoActiveOrUpcomingGaolViewController.swift
//  Nail Goals
//
//  Created by Sparty on 6/6/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class YourGoalsNoActiveOrUpcomingGaolViewController: UIViewController {
    
    
    var goalObjectId = NSUserDefaults.standardUserDefaults().objectForKey(kPresentGoaltId) as! NSString
    var startDate = NSUserDefaults.standardUserDefaults().objectForKey(kstartDate)as! NSString
    var endDate = NSUserDefaults.standardUserDefaults().objectForKey(kendDate) as! NSString
    var userName = NSUserDefaults.standardUserDefaults().objectForKey(KuserNameKey) as! NSString
    var remainderObjId = NSUserDefaults.standardUserDefaults().objectForKey(kreminderObjectId) as! NSString
    
    
    //variables
    
    var currentDate = NSDate()
    var noOfDaysFromLastGoal: Int  = 0

    @IBOutlet var pastGoalDate: UILabel!
    @IBOutlet var dayAgoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noOfDaysFromLastGoal = self.claculateNoOfDaysAgoGoal(self.endDate as String, endDate: currentDate)
        self.dayAgoLabel.text = "\(noOfDaysFromLastGoal)" + " Days Ago!"
        self.pastGoalDate.text = self.formatDateForUI(self.endDate as String)

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func claculateNoOfDaysAgoGoal(startDate: String, endDate: NSDate)-> Int{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let startDt:NSDate = dateFormatter.dateFromString(startDate)!
        let endDt:NSDate = endDate
        
        let cal = NSCalendar.currentCalendar()
        
        let unit:NSCalendarUnit = NSCalendarUnit.CalendarUnitDay
        
        let components = cal.components(unit, fromDate: startDt, toDate: endDt, options: nil)
        return components.day
    }
    
    func formatDateForUI(dt: String) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let date:NSDate = dateFormatter.dateFromString(dt)!
        let flags: NSCalendarUnit = (NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitYear)
        let components = NSCalendar.currentCalendar().components(flags, fromDate: date)
        var year = "\(components.year)"
        var month = getMonthName(components.month)
        var day = "\(components.day)"
        var UIDateString = month + " " + day + " " +  year
        return UIDateString
        
    }
    
    func getMonthName(month: Int)->String{
        var monthName: String?
        switch month {
            
            
        case 1:
            monthName = "JAN"
        case 2:
            monthName = "FEB"
        case 3:
            monthName = "MAR"
        case 4:
            monthName = "APR"
        case 5:
            monthName = "MAY"
        case 6:
            monthName = "JUNE"
        case 7:
            monthName = "JULY"
        case 8:
            monthName = "AUG"
        case 9:
            monthName = "SEP"
        case 10:
            monthName = "OCT"
        case 11:
            monthName = "NOV"
        case 12:
            monthName = "DEC"
        default:
            monthName  = ""
        }
        return monthName!
        
        
    }





}
