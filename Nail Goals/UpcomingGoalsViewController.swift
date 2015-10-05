//
//  UpcomingGoalsViewController.swift
//  Nail Goals
//
//  Created by Sparty on 6/6/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
// as

import UIKit

class UpcomingGoalsViewController: UIViewController {
    
    var goalObjectId = NSUserDefaults.standardUserDefaults().objectForKey(kPresentGoaltId) as! NSString
    var startDate = NSUserDefaults.standardUserDefaults().objectForKey(kstartDate)as! NSString
    var endDate = NSUserDefaults.standardUserDefaults().objectForKey(kendDate) as! NSString
    var userName = NSUserDefaults.standardUserDefaults().objectForKey(KuserNameKey) as! NSString
    var remainderObjId = NSUserDefaults.standardUserDefaults().objectForKey(kreminderObjectId) as! NSString

    
    //variables
    
    var currentDate = NSDate()
    var noOfDaysLefttoStartNewGoal: Int  = 0

    @IBOutlet var daysLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noOfDaysLefttoStartNewGoal = self.claculateNoOfDaysAgoGoal(self.startDate as String, endDate: currentDate)
        self.daysLabel.text = "\(noOfDaysLefttoStartNewGoal)" + " days"

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
        
        let components = cal.components(unit, fromDate: endDt, toDate: startDt, options: nil)
        return components.day
    }

}
