//
//  PastGaolsOverViewViewController.swift
//  Nail Goals
//
//  Created by Sparty on 6/6/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class PastGaolsOverViewViewController: UIViewController {
    
    var startDateInGoal: String?
    var endDateInGoal: String?
    let currentdate = NSDate()
    var noOfDaysInGoalArray = [Int]()
    var userName = NSUserDefaults.standardUserDefaults().objectForKey(KuserNameKey) as! NSString
    var biteCounter = 0
    var biteFreeCounter = 0
    var pastGoalId: String?
    
    @IBOutlet var DaysAgoLabel: UILabel!
    
    @IBOutlet var GoalLengthLabel: UILabel!
    
    @IBOutlet var StartDateLabel: UILabel!
    
    @IBOutlet var EndDateLabel: UILabel!
    
    @IBOutlet var BiteFreeLabel: UILabel!
    
    @IBOutlet var BiteLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        var query = PFQuery(className:"goalClass")
        query.whereKey("userName", equalTo:userName)
        query.whereKey("startDate", equalTo:startDateInGoal!)
        query.getFirstObjectInBackgroundWithBlock {
            (objects: PFObject!, error: NSError!) -> Void in
            if error == nil {
                println("pastgoalsSuccess")
                self.noOfDaysInGoalArray = objects["daysArray"] as! [Int]
                self.pastGoalId = objects.objectId as NSString as String
                self.StartDateLabel.text = self.startDateInGoal!
                self.EndDateLabel.text = self.endDateInGoal!
                self.DaysAgoLabel.text = "\(self.claculateNoOfDaysAgoGoal(self.startDateInGoal!, endDate: self.currentdate ))" + " Days Ago"
                self.GoalLengthLabel.text = "\(self.claculateNoOfDaysInGoal(self.startDateInGoal!, endDate: self.endDateInGoal!))" + " Days"
                self.BiteFreeLabel.text = "\(self.retrunBiteFreeCounter(self.noOfDaysInGoalArray))"
                self.BiteLabel.text = "\(self.retrunBiteCounter(self.noOfDaysInGoalArray))"
                
            } else {
                println("pastgoalsOverViewError")
                
            }
        }
        
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func retrunBiteCounter(GoalArray: [Int]) ->Int{
        for (var index = 0; index < GoalArray.count; index++) {
            
            if(GoalArray[index] != 0 ){
                biteCounter++
                
            }
        }
        return biteCounter
    }
    
    func retrunBiteFreeCounter(GoalArray: [Int]) ->Int{
        for (var index = 0; index < GoalArray.count; index++) {
            
            if(GoalArray[index] == 0 ){
                biteFreeCounter++
                
            }
        }
        return biteFreeCounter
        
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
    
    func claculateNoOfDaysInGoal(startDate: String, endDate: String)-> Int{
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let startDt:NSDate = dateFormatter.dateFromString(startDate)!
        let endDt:NSDate = dateFormatter.dateFromString(endDate)!
        
        let cal = NSCalendar.currentCalendar()
        
        let unit:NSCalendarUnit = NSCalendarUnit.CalendarUnitDay
        
        let components = cal.components(unit, fromDate: startDt, toDate: endDt, options: nil)
        return components.day
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "PastGoalBiteTrackerSegue" {
            
            let destinationController = segue.destinationViewController as! BiteTrackerViewController
            destinationController.biteDays = biteCounter
            destinationController.biteFreeDays = biteFreeCounter
            destinationController.noOfDaysArray = self.noOfDaysInGoalArray
            destinationController.startDate = self.startDateInGoal
            
            
        }
//        else if segue.identifier == "SegueToComaprePictures" {
//            let destinationController = segue.destinationViewController as! ProgressImagesViewController
//            destinationController.goalObjId = self.pastGoalId
//        }
        
    }

    

    
}
