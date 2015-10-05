//
//  YourNailViewController.swift
//  Nail Goals
//
//  Created by Sparty on 5/31/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class YourNailViewController: UIViewController {
    
    
    var goalObjectId = NSUserDefaults.standardUserDefaults().objectForKey(kPresentGoaltId) as! NSString
    var startDate = NSUserDefaults.standardUserDefaults().objectForKey(kstartDate)as! NSString
    var endDate = NSUserDefaults.standardUserDefaults().objectForKey(kendDate) as! NSString
    var userName = NSUserDefaults.standardUserDefaults().objectForKey(KuserNameKey) as! NSString
    var remainderObjId = NSUserDefaults.standardUserDefaults().objectForKey(kreminderObjectId) as! NSString
    
    var noOfDaysInGoalArr = [Int]()
    let currentDate = NSDate()
    var weekDaysArray = [Int]()
    var currentDay: String?
    

    @IBOutlet var daysLeft: UILabel!
    @IBOutlet var progressView: UIProgressView!
    @IBOutlet var totalNoOfDaysINGoal: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        var noOfDays: Int = claculateNoOfDaysinGoal(self.startDate as String, endDate: self.endDate as String ) + 1
        self.daysLeft.text = "\(noOfDays)"
        
        var presentDay: Int = noOfDays - self.claculatePresentDayInGoal(self.startDate as String, date: self.currentDate)
         self.totalNoOfDaysINGoal.text = "\(presentDay)"

        // To Calculate the current day in goal
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // calculate present day in goal
    func claculatePresentDayInGoal(startDate: String, date: NSDate)-> Int{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let startDt:NSDate = dateFormatter.dateFromString(startDate)!
        //let endDt:NSDate = dateFormatter.dateFromString(endDate)!
        
        let cal = NSCalendar.currentCalendar()
        
        let unit:NSCalendarUnit = (NSCalendarUnit.CalendarUnitDay)
        
        let components = cal.components(unit, fromDate: startDt, toDate: currentDate, options: nil)
        return components.day
    }
    
    
    func claculateNoOfDaysinGoal(startDate: String, endDate: String)-> Int{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let startDt:NSDate = dateFormatter.dateFromString(startDate)!
        let endDt:NSDate = dateFormatter.dateFromString(endDate)!
        
        let cal = NSCalendar.currentCalendar()
        
        let unit:NSCalendarUnit = (NSCalendarUnit.CalendarUnitDay)
        
        let components = cal.components(unit, fromDate: startDt, toDate: endDt, options: nil)
        return components.day
    }

    
    func customizeProgressView(){
        let myProgressColor = UIColor( red: 43/255, green: 178/255, blue:212/255, alpha: 1.0 )
        var transform : CGAffineTransform  = CGAffineTransformMakeScale(1.0, 6)
        self.progressView.transform = transform;
        self.progressView.progress = Float(currentDayInGoal)/Float(self.noOfDaysInGoalArr.count)
        self.progressView.trackTintColor = UIColor.lightGrayColor()
        self.progressView.tintColor = myProgressColor
        
    }

   
    @IBAction func viewPastGoals(sender: AnyObject) {
        
        var storyboard: UIStoryboard = UIStoryboard(name: "Your Nail Goals - Post Dashboard", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("yourNailGoals") as! PastGoalsViewController
        self.showViewController(vc, sender: self)
        
    }

}
