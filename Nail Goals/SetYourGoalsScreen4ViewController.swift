//
//  SetYourGoalsScreen4ViewController.swift
//  Nail Goals
//
//  Created by Sparty on 5/23/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class SetYourGoalsScreen4ViewController: UIViewController {
    var userName = NSUserDefaults.standardUserDefaults().objectForKey(KuserNameKey) as! NSString
    var startDate = NSUserDefaults.standardUserDefaults().objectForKey(kstartDate)as! NSString
    var endDate = NSUserDefaults.standardUserDefaults().objectForKey(kendDate)as! NSString
    var objectId = NSUserDefaults.standardUserDefaults().objectForKey(kobjectId) as! NSString
    
    //outlets
    @IBOutlet var endDateLabel: UILabel!
    @IBOutlet var startDateLabel: UILabel!
    
    //variables
    
     var daysInGoal: [Int]  = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startDateLabel.text = formatDateForUI(self.startDate as String)
        self.endDateLabel.text = formatDateForUI(self.endDate as String)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    @IBAction func navToRemindersScreen(sender: AnyObject) {
        
        
        
        
        
        
        var noOfDays: Int = claculateNoOfDaysinGoal(self.startDateLabel.text!, endDate: self.endDateLabel.text! )
        
        //var PFUserObject =  PfUserObject()
        //var user = PFUserObject.sessionUserObject
        var goalObject =  PFObject(className: "goalClass")
        goalObject["userName"] = userName
        goalObject["startDate"] = self.startDate
        goalObject["endDate"] = self.endDate
        goalObject["noOfDays"] = noOfDays
        
        for   i in 0 ... noOfDays{
            if noOfDays > 30{
                break
            }
            var ngDaysCounter = i
            daysInGoal.append(0)
            
            //                println(ngDaysCounter)
            //                goalObject[ngDaysCounter] = 0
            
        }
        goalObject["daysArray"] = daysInGoal
        
        goalObject.saveInBackgroundWithBlock{
            (successObjectLeft: Bool, errorObjectLeft: NSError!) -> Void in
            if(errorObjectLeft == nil){
                
                var nggoalObjId = goalObject.objectId as NSString
                var ngUserquery = PFQuery(className:"NailGoalsUser")
                ngUserquery.getObjectInBackgroundWithId(self.objectId as! String) {
                    (ngUserObject: PFObject!, error: NSError!) -> Void in
                    if error != nil {
                        NSLog("%@", error)
                    } else {
                        ngUserObject["startDate"] = self.startDate
                        ngUserObject["endDate"] = self.endDate
                        ngUserObject.saveInBackground();
                        
                        
                        NSUserDefaults.standardUserDefaults().setObject(nggoalObjId, forKey: kPresentGoaltId)
                        println(NSUserDefaults.standardUserDefaults().objectForKey(kPresentGoaltId) as! NSString)
                        NSUserDefaults.standardUserDefaults().setObject(self.startDate, forKey: kstartDate)
                        NSUserDefaults.standardUserDefaults().setObject(self.endDate, forKey: kendDate)
                        var storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        var vc = storyboard.instantiateViewControllerWithIdentifier("remindersScreen1") as! WlakthroughRemindersViewController
                        self.showViewController(vc, sender: self)
                    }
                }
                
                
            }
            else{
                println("errorSavingGoalObject")
            }
            
        }
        

        
       
        
        
    }
   
    
    // to remove the satus bar
    override func prefersStatusBarHidden() -> Bool {
        
        return true;
    }
 
    


}
