//
//  dashboardViewController.swift
//  Nail Goals
//
//  Created by Sparty on 5/16/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit
 var currentDayInGoal: Int = 0
class dashboardViewController: UIViewController {
    
    
    
    var goalObjectId = NSUserDefaults.standardUserDefaults().objectForKey(kPresentGoaltId) as! NSString
    var startDate = NSUserDefaults.standardUserDefaults().objectForKey(kstartDate)as! NSString
    var endDate = NSUserDefaults.standardUserDefaults().objectForKey(kendDate) as! NSString
    var userName = NSUserDefaults.standardUserDefaults().objectForKey(KuserNameKey) as! NSString
    var remainderObjId = NSUserDefaults.standardUserDefaults().objectForKey(kreminderObjectId) as! NSString
    
    
    
    //labels
    @IBOutlet var counterNumber: UILabel!
    @IBOutlet var daysLeft: UILabel!
    @IBOutlet var nextReminderLabel: UILabel!
    @IBOutlet var progressView: UIProgressView!
    
    
    
    
    
    //variables
   

    var noOfDaysInGoalArr = [Int]()
    let currentDate = NSDate()
    var weekDaysArray = [Int]()
    var reminderTimesArray = [String]()
    var currentDay = NSDate()
    var nextReminderDay: String?
    var AMArray: [String] = []
    var PMArray: [String] = []
    var sortedRemindersArray: [String] = []
    var skipRemindersFalg: Bool = false;
    
    
    //views
    
    @IBOutlet var noReminderContainerView: UIView!
    
    
    @IBOutlet var PasgoalsViewConatiner: UIView!
    
    @IBOutlet var MainDashboardView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.noReminderContainerView.hidden = true
//        self.PasgoalsViewConatiner.hidden = true
        
        
        currentDayInGoal = claculatePresentDayInGoal(startDate as String, date: currentDate)
        
        var query = PFQuery(className:"goalClass")
        query.whereKey("userName", equalTo:userName)
        query.whereKey("startDate", equalTo:startDate)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                for object in objects {
                    self.noOfDaysInGoalArr = object["daysArray"] as! [Int]
                 
                   
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
                                    self.sortReminderTimes(self.reminderTimesArray)
                                    self.calNextReminderDayandTime()
                                    
                                    
                                }
                                else {
                                    //self.noReminderContainerView.hidden = false
                                }
                                self.daysLeft.text = "\(self.noOfDaysInGoalArr.count - currentDayInGoal )"
                                self.customizeProgressView()
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
    
    
    
    
    
    
    
    
    
    // + Action Button
    @IBAction func addBiteTimes(sender: AnyObject) {
        
        var biteNumber: Int = self.counterNumber.text!.toInt()!
        biteNumber = biteNumber + 1
        
        noOfDaysInGoalArr[currentDayInGoal] = biteNumber
        
        var query = PFQuery(className:"goalClass")
        println(goalObjectId)
        query.getObjectInBackgroundWithId(goalObjectId as String) {
            (goalObject: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
                println("pluserror")
            } else {
                goalObject["daysArray"] = self.noOfDaysInGoalArr
                goalObject.saveInBackground()
                self.counterNumber.text = "\(biteNumber)"
                println("plussuccess")
                
            }
        }
        
        
        
    }
    //- Action Button
    @IBAction func minusBiteTimes(sender: AnyObject) {
        
        var biteNumber: Int = self.counterNumber.text!.toInt()!
        biteNumber = biteNumber - 1
         if(biteNumber == -1){
            
            let alertMessage = UIAlertController(title: "", message: "Bite counter cannot be less than 0", preferredStyle: .Alert);
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        
         else {
        
        
            noOfDaysInGoalArr[currentDayInGoal] = biteNumber
            
            var query = PFQuery(className:"goalClass")
            println(goalObjectId)
            query.getObjectInBackgroundWithId(goalObjectId as String) {
                (goalObject: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    goalObject["daysArray"] = self.noOfDaysInGoalArr
                    goalObject.saveInBackground()
                    self.counterNumber.text = "\(biteNumber)"
                    println("plussuccess")
                    
                }
            }
        }
    }
    
    func customizeProgressView(){
        let myProgressColor = UIColor( red: 43/255, green: 178/255, blue:212/255, alpha: 1.0 )
        var transform : CGAffineTransform  = CGAffineTransformMakeScale(1.0, 6)
        self.progressView.transform = transform;
        self.progressView.progress = Float(currentDayInGoal)/Float(self.noOfDaysInGoalArr.count)
        self.progressView.trackTintColor = UIColor.lightGrayColor()
        self.progressView.tintColor = myProgressColor
    
    }
    
    
    //functions to calculate the next reminders
    
    func calNextReminderDayandTime(){
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayOfWeekString = dateFormatter.stringFromDate(currentDate)
        
        dateFormatter.timeStyle = .ShortStyle
        let timeString = dateFormatter.stringFromDate(currentDate)
        calculateNextReminderDay(dayOfWeekString, currTime: timeString)
        println(timeString)
        
    }
    
    
    
    func calculateNextReminderDay(dayOfWeekString: String, currTime: String){
        var currentDayOfTheWeek = dayOfWeekString
        var curDayNo = self.getCurrentDayForNextReminder(currentDayOfTheWeek)
        
        if(weekDaysArray[curDayNo] == 1){
            for (var i: Int = 0; i < reminderTimesArray.count; i++){
                
                var reminderTimeisgraterFlag: Bool =  self.compareTime(self.splitTime(currTime), reminderTime: self.splitTime(reminderTimesArray[i]))
                if(reminderTimeisgraterFlag){
                    
                    self.nextReminderLabel.text = self.getCurrentDayNameForNextReminder(curDayNo) + ", "
                    + reminderTimesArray[i]
                    break;
                }
                else{
                    if(self.ReminderAfterToday(curDayNo)){
                         self.nextReminderLabel.text = nextReminderDay! + ", "  + reminderTimesArray[i]
                        
                    }
                    else if(self.ReminderBeforeToday(curDayNo)){
                         self.nextReminderLabel.text = nextReminderDay! + ", "  + reminderTimesArray[i]
                        
                    }
                    
                    
                }
            }
        }
            
        else if(self.ReminderAfterToday(curDayNo)){
            self.nextReminderLabel.text = nextReminderDay! + ", " + sortedRemindersArray[0]
            
        }
        else if(self.ReminderBeforeToday(curDayNo)){
             self.nextReminderLabel.text = nextReminderDay! + ", " + sortedRemindersArray[0]
            
        }
        
        
        
    }
    
    
    
    func ReminderAfterToday(curDayNo:Int)->Bool{
        var returnflag = false
        for(var i: Int = curDayNo+1; i < weekDaysArray.count; i++){
            if(weekDaysArray[i] == 1){
                nextReminderDay = self.getCurrentDayNameForNextReminder(i)
                returnflag = true
                break
            }
        }
        return returnflag
        
    }
    
    func ReminderBeforeToday(curDayNo:Int)->Bool{
        var returnflag = false
        for(var i: Int = 0; i < curDayNo; i++){
            if(weekDaysArray[i] == 1){
                nextReminderDay = self.getCurrentDayNameForNextReminder(i)
                returnflag = true
                break
            }
        }
        return returnflag
        
    }
    
    
    
    
    func getCurrentDayForNextReminder(curDay:String)->Int {
        
        var CurrentDayNumber: Int = 0
        switch curDay{
        case "Sunday":
            CurrentDayNumber = 0
        case "Monday":
            CurrentDayNumber = 1
        case "Tuesday":
            CurrentDayNumber = 2
        case "Wednesday":
            CurrentDayNumber = 3
        case "Thursday":
            CurrentDayNumber = 4
        case "Friday":
            CurrentDayNumber = 5
        case "Saturday":
            CurrentDayNumber = 6
        default:
            CurrentDayNumber = 0
        }
        return CurrentDayNumber
        
        
        
    }
    
    func getCurrentDayNameForNextReminder(curDay:Int)->String {
        
        var CurrentDayName: String = ""
        switch curDay{
        case 0:
            CurrentDayName = "Sunday"
        case 1:
            CurrentDayName = "Monday"
        case 2:
            CurrentDayName = "Tuesday"
        case 3:
            CurrentDayName = "Wednesday"
        case 4:
            CurrentDayName = "Thursday"
        case 5:
            CurrentDayName = "Friday"
        case 6:
            CurrentDayName = "Saturday"
        default:
            CurrentDayName = ""
        }
        return CurrentDayName
        
        
        
    }
    
    
    func splitTime(Time:String)->[String]{
        
        var TimeArr = split(Time) {$0 == " "}
        return TimeArr
    }
    
    
    func compareTime(currentTime: [String] , reminderTime:[String]) -> Bool{
        
        
        if(currentTime[1] ==  reminderTime[1]){
            
            var dateComparisionResult:NSComparisonResult = currentTime[0].compare(reminderTime[0])
            
            if dateComparisionResult == NSComparisonResult.OrderedAscending
            {
                println("Current time is smaller than end date.")
                return true
                // Current date is smaller than end date.
            }
            else if dateComparisionResult == NSComparisonResult.OrderedDescending
            {
                println("Current time is grater than end date.")
                return false
                // Current date is greater than end date.
            }
            else if dateComparisionResult == NSComparisonResult.OrderedSame
            {
                return false
                // Current date and end date are same.
            }
            
            
        }
        else if( currentTime[1] == "AM" && reminderTime[1] == "PM" ){
            
            return true
        }
            
        else{
            
            return false
        }
        return false
        
    }
    
    
    func sortReminderTimes(reminderTimeArray: [String]){
        for (var i: Int = 0; i < reminderTimeArray.count; i++ ){
            var splitTineForSort: [String] = self.splitTime(reminderTimeArray[i])
            if(splitTineForSort[1] == "AM"){
                AMArray.append(reminderTimeArray[i])
                
            }
            else if(splitTineForSort[1] == "PM"){
                PMArray.append(reminderTimeArray[i])
                
            }
            
        }
        
        if(!AMArray.isEmpty){
            AMArray = sorted(AMArray) { $0 < $1 }
        }
        if(!AMArray.isEmpty){
            PMArray = sorted(PMArray) { $0 > $1 }
        }
        
        self.sortedRemindersArray =  AMArray + PMArray
        println(sortedRemindersArray)
        
        
        
    }
    
    // functions to calculate the next reminders end
   
    
    
    // to remove the satus bar
    override func prefersStatusBarHidden() -> Bool {
        
        return true;
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
    
  

    @IBAction func viewPastGoals(sender: AnyObject) {
        
        self.MainDashboardView.hidden = true
        self.PasgoalsViewConatiner.hidden = false

        
    }

}
