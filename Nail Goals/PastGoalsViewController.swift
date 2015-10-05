//
//  PastGoalsViewController.swift
//  Nail Goals
//
//  Created by Sparty on 5/27/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class PastGoalsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet var tableView: UITableView!
    
    
    var userName = NSUserDefaults.standardUserDefaults().objectForKey(KuserNameKey)as! NSString
    
    var currentStartDate = NSUserDefaults.standardUserDefaults().objectForKey(kstartDate) as! NSString
    
    
    var totalNoOfGoals: Int = 0
    
    var startDate = [String]()
    
    var endDate = [String]()
    
    var noOfDaysInGoal = [Int]()
    
    let currentDate = NSDate()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
        
        
        var query = PFQuery(className:"goalClass")
        query.whereKey("userName", equalTo:userName)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("pastgoalsSuccess")
                for object in objects {
                    var stDt = object["startDate"] as! String
                    var endDt = object["endDate"] as! String
                    
                    if(self.currentStartDate !=  stDt){
                        self.noOfDaysInGoal.append(self.claculateNoOfDaysAgoGoal(stDt, endDate: self.currentDate))
                        self.startDate.append(stDt)
                        self.endDate.append(endDt)
                    }
                }
                self.totalNoOfGoals = self.noOfDaysInGoal.count
                self.tableView.reloadData()
            } else {
                println("pastgoalsError")
                
            }
        }
        
        
        
        
        super.viewDidLoad()
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
    

    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return totalNoOfGoals
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        println(indexPath.row)
        
        
        
        var cell: pastGoalsTableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell") as! pastGoalsTableViewCell
        cell.startDateLabel.text =  startDate[indexPath.row]
        cell.endDateLabel.text =  endDate[indexPath.row]
        cell.daysAgoLabel.text = "\(noOfDaysInGoal[indexPath.row]) " + "Days Ago"
        return cell
        
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
       return 123
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "PastGaolsOverViewSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let destinationController = segue.destinationViewController as! PastGaolsOverViewViewController
                destinationController.startDateInGoal = startDate[indexPath.row]
                destinationController.endDateInGoal = endDate[indexPath.row]
                
            }
        }
    }
    


    

   

}
