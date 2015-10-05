//
//  MainDashboardViewController.swift
//  Nail Goals
//
//  Created by Sparty on 6/3/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class MainDashboardViewController: UIViewController {
    
    
    var goalObjectId = NSUserDefaults.standardUserDefaults().objectForKey(kPresentGoaltId) as! NSString
    var startDate = NSUserDefaults.standardUserDefaults().objectForKey(kstartDate)as! NSString
    var endDate = NSUserDefaults.standardUserDefaults().objectForKey(kendDate) as! NSString
    var userName = NSUserDefaults.standardUserDefaults().objectForKey(KuserNameKey) as! NSString
    var remainderObjId = NSUserDefaults.standardUserDefaults().objectForKey(kreminderObjectId) as! NSString

    
    
    
    
    
    //variables
    
    
    var noOfDaysInGoalArr = [Int]()
    let currentDate = NSDate()
    var weekDaysArray = [Int]()
    var reminderTimesArray: [String] = []
    var currentDay = NSDate()
    var nextReminderDay: String?
    var AMArray: [String] = []
    var PMArray: [String] = []
    var sortedRemindersArray: [String] = []
    var skipRemindersFalg: Bool = false;
    var noGoalFalg: Bool = false;
    var noUpcomingGoalFalg: Bool = false;
    var UpcomingGoalFalg: Bool = false;
    
    
    //views
    @IBOutlet var homeDasboardView: UIView!
    
    @IBOutlet var yourNailGoalsView: UIView!
    
    @IBOutlet var noGoalView: UIView!
    
    @IBOutlet var upcomingGoalView: UIView!
    
    @IBOutlet var yourNailGoalsNoGoalView: UIView!
    
    @IBOutlet var progressScreenView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.homeDasboardView.hidden = true;
        self.yourNailGoalsView.hidden = true;
        self.noGoalView.hidden = true;
        self.upcomingGoalView.hidden = true;
        self.yourNailGoalsNoGoalView.hidden = true;
        self.progressScreenView.hidden = true;
        

        // Do any additional setup after loading the view.
        
        
        var query = PFQuery(className:"goalClass")
        query.whereKey("userName", equalTo:userName)
        query.whereKey("startDate", equalTo:startDate)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    self.noOfDaysInGoalArr = object["daysArray"] as! [Int]
                    
                    if(  self.isGreaterThanDate(self.startDate as String)  ){
                        self.noGoalFalg = true
                        self.homeDasboardView.hidden = true;
                        self.noGoalView.hidden = true;
                        self.upcomingGoalView.hidden = false;
                        self.yourNailGoalsView.hidden = true;
                        self.yourNailGoalsNoGoalView.hidden = true;
                        self.UpcomingGoalFalg = true
                         self.progressScreenView.hidden = true;

                    }
                        
                    else if(self.isLessThanDate(self.endDate as String) ){
                        self.noGoalFalg = true
                        self.homeDasboardView.hidden = true;
                        self.noGoalView.hidden = false;
                        self.upcomingGoalView.hidden = true;
                        self.yourNailGoalsView.hidden = true;
                        self.yourNailGoalsNoGoalView.hidden = true;
                        self.noUpcomingGoalFalg = true
                         self.progressScreenView.hidden = true;
                        
                        
                    }
                    else {
                        self.homeDasboardView.hidden = false;
                        self.noGoalView.hidden = true;
                        // to get the reminder object
                        println("goalsuccess")
                        var reminderQuery = PFQuery(className:"reminderClass")
                        reminderQuery.getObjectInBackgroundWithId(self.remainderObjId as String) {
                            (reminderObj: PFObject!, error: NSError!) -> Void in
                            if error != nil {
                                NSLog("%@", error)
                                println("pluserror")
                            } else {
                                println("remindersuccess")
                                println(reminderObj)
                                self.skipRemindersFalg = reminderObj["skipReminders"] as! Bool
                                 NSUserDefaults.standardUserDefaults().setBool(self.skipRemindersFalg, forKey: "kskipRemindersFalg")
                                // show Add reminders button if reminders are skipped
                                if(!self.skipRemindersFalg ){
                                    self.reminderTimesArray = reminderObj["remindersArray"] as! [String]
                                    self.weekDaysArray = reminderObj["weekDayArray"] as! [Int]
                                    
                                    
                                }
                                else {
                                    //self.noReminderContainerView.hidden = false
                                }
                                                            
                            }
                        }
                    }
                }
                
                
                
                
                
                
                
            }
            else{
                println("error to get goals")
                println(error)
                
            }
        }
        

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func isGreaterThanDate(SDate : String) -> Bool
    {
        //Declare Variables
        var isGreater = false
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let startDt:NSDate = dateFormatter.dateFromString(SDate)!
        
        var dateComparisionResult:NSComparisonResult = self.currentDate.compare(startDt)
        
        //Compare Values
        if dateComparisionResult == NSComparisonResult.OrderedAscending
        {
            isGreater = true
        }
        
        //Return Result
        return isGreater
    }
    
    func isLessThanDate(EDate : String) -> Bool
    {
        //Declare Variables
        var isLesser = false
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let endDt:NSDate = dateFormatter.dateFromString(EDate)!
        
        var dateComparisionResult:NSComparisonResult = self.currentDate.compare(endDt)
        
        //Compare Values
        if dateComparisionResult == NSComparisonResult.OrderedDescending
        {
            isLesser = true
        }
        
        //Return Result
        return isLesser
    }
    
    @IBAction func yourNailGoals(sender: AnyObject) {
        
        if(self.noGoalFalg){
            self.homeDasboardView.hidden = true;
            self.yourNailGoalsView.hidden = true;
            self.upcomingGoalView.hidden = true;
            self.noGoalView.hidden = true;
            self.yourNailGoalsNoGoalView.hidden = false;
            
        }
        else {
            self.homeDasboardView.hidden = true;
            self.yourNailGoalsView.hidden = false;
            self.upcomingGoalView.hidden = true;
            self.noGoalView.hidden = true;
            self.yourNailGoalsNoGoalView.hidden = true;
            
        }

        

        
    }

    @IBAction func mainDashBoard(sender: AnyObject) {
        if (self.UpcomingGoalFalg){
            self.homeDasboardView.hidden = true;
            self.yourNailGoalsView.hidden = true;
            self.noGoalView.hidden = true;
            self.yourNailGoalsNoGoalView.hidden = true;
            self.progressScreenView.hidden = true;
            self.upcomingGoalView.hidden = false;
            
        }
        
        else if (self.noUpcomingGoalFalg){
            self.homeDasboardView.hidden = true;
            self.yourNailGoalsView.hidden = true;
            self.upcomingGoalView.hidden = true;
            self.yourNailGoalsNoGoalView.hidden = true;
            self.progressScreenView.hidden = true;
            self.noGoalView.hidden = false;
            
        }
        else {
            self.yourNailGoalsView.hidden = true;
            self.upcomingGoalView.hidden = true;
            self.noGoalView.hidden = true;
            self.yourNailGoalsNoGoalView.hidden = true;
            self.progressScreenView.hidden = true;
            self.homeDasboardView.hidden = false;

            
        }
        
       
        
    }
    
   
    @IBAction func showProgressView(sender: AnyObject) {
        
        self.homeDasboardView.hidden = true;
        self.yourNailGoalsView.hidden = true;
        self.noGoalView.hidden = true;
        self.yourNailGoalsNoGoalView.hidden = true;
        self.upcomingGoalView.hidden = true;
        self.progressScreenView.hidden = false;
        

    }
    
    
}
