//
//  WlakthroughRemindersViewController.swift
//  Nail Goals
//
//  Created by Sparty on 5/4/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit
import Parse

class WlakthroughRemindersViewController: UIViewController {
     var userName = NSUserDefaults.standardUserDefaults().objectForKey(KuserNameKey) as! NSString
     var reminderCounter: Int = 1
     var sundayFlag: Bool = false;
     var mondayFlag: Bool = false;
     var tuesdayFlag: Bool = false;
     var wednesdayFlag: Bool = false;
     var thursdayFlag: Bool = false;
     var fridayFlag: Bool = false;
     var saturdayFlag: Bool = false;
     var reminderObjId = ""
    var weekDaysArray: [Int] = [0,0,0,0,0,0,0]
    var remindersArray: [String] = ["", "", "", "", "", "", "", "", "", ""]
    @IBOutlet var remindersCounterLabel: UILabel!
    @IBOutlet var sundayButton: UIButton!
    @IBOutlet var monButton: UIButton!
    @IBOutlet var tueButton: UIButton!
    @IBOutlet var wedButton: UIButton!
    @IBOutlet var thuButton: UIButton!
    @IBOutlet var friButton: UIButton!
    @IBOutlet var satButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        var reminderObject =  PFObject(className: "reminderClass")
        reminderObject["userName"] = userName
        reminderObject["SUN"] = 0;
        reminderObject["MON"] = 0;
        reminderObject["TUE"] = 0;
        reminderObject["WED"] = 0;
        reminderObject["THU"] = 0;
        reminderObject["FRI"] = 0;
        reminderObject["SAT"] = 0;
        reminderObject["noOfreminders"] = reminderCounter
        reminderObject["weekDayArray"] = self.weekDaysArray
        reminderObject["remindersArray"] = self.remindersArray
        reminderObject["skipReminders"] = false
        reminderObject.saveInBackgroundWithBlock{
            (successObjectLeft: Bool, errorObjectLeft: NSError!) -> Void in
            if(errorObjectLeft == nil){
                 self.reminderObjId = reminderObject.objectId as NSString as String
                NSUserDefaults.standardUserDefaults().setObject(self.reminderObjId, forKey: kreminderObjectId)
             println("SuccessforReminders")
                
                
            }
            else{
                println("errorSavingGoalObject")
            }
            
        }


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlusButton(sender: AnyObject) {
         reminderCounter = self.remindersCounterLabel.text!.toInt()!
        if(reminderCounter < 10){
            reminderCounter = reminderCounter + 1
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["noOfreminders"] = self.reminderCounter
                    reminderObj.saveInBackground()
                    self.remindersCounterLabel.text = "\(self.reminderCounter)"
                    println("plussuccess")
                    
                }
            }
        }
        
        else if(reminderCounter == 10){
            
            let alertMessage = UIAlertController(title: "", message: "Number of reminders cannot be grater than 10", preferredStyle: .Alert);
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        
        
    }

    @IBAction func minusButton(sender: AnyObject) {
        reminderCounter = self.remindersCounterLabel.text!.toInt()!
        if(reminderCounter >= 2){
            reminderCounter = reminderCounter - 1
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["noOfreminders"] = self.reminderCounter
                    reminderObj.saveInBackground()
                    self.remindersCounterLabel.text = "\(self.reminderCounter)"
                    println("plussuccess")
                    
                }
            }

        }
        
        else if(reminderCounter == 1){
            
            let alertMessage = UIAlertController(title: "", message: "Number of reminders cannot be less than 1", preferredStyle: .Alert);
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        
        
        
    }
    
    
    @IBAction func SundayButton(sender: AnyObject) {
        if(self.sundayFlag){
            sundayFlag = false
            self.sundayButton.selected = false;
            self.weekDaysArray[0] = 0
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["SUN"] = 0;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }

        }
        else{
            sundayFlag = true
            self.sundayButton.selected = true;
            self.weekDaysArray[0] = 1
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["SUN"] = 1;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }

        }
        
    }
    @IBAction func MondayButton(sender: AnyObject) {
        if(self.mondayFlag){
            self.monButton.selected = false;
            mondayFlag = false
            self.weekDaysArray[1] = 0
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["MON"] = 0;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }
        else{
            mondayFlag = true
            self.monButton.selected = true;
            self.weekDaysArray[1] = 1
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["MON"] = 1;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }

        
        
    }
    @IBAction func TuesdayButton(sender: AnyObject) {
        if(self.tuesdayFlag){
            tuesdayFlag = false
            self.tueButton.selected = false;
            self.weekDaysArray[2] = 0
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["TUE"] = 0;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }
        else{
            tuesdayFlag = true
            self.tueButton.selected = true;
            self.weekDaysArray[2] = 1
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["TUE"] = 1;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }

        
    }
    @IBAction func WednesdayButton(sender: AnyObject) {
        if(self.wednesdayFlag){
            wednesdayFlag = false
              self.wedButton.selected = false;
            self.weekDaysArray[3] = 0
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["WED"] = 0;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }
        else{
            wednesdayFlag = true
            self.wedButton.selected = true;
            self.weekDaysArray[3] = 1
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["WED"] = 1;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }
        

        
    }
    @IBAction func ThursdayButton(sender: AnyObject) {
        if(self.thursdayFlag){
            thursdayFlag = false
            self.weekDaysArray[4] = 0
            self.thuButton.selected = false;
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["THU"] = 0;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }
        else{
            thursdayFlag = true
            self.thuButton.selected = true;
            self.weekDaysArray[4] = 1
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["THU"] = 1;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }

        
    }
    @IBAction func FridayButton(sender: AnyObject) {
        if(self.fridayFlag){
            fridayFlag = false
            self.friButton.selected = false;
            self.weekDaysArray[5] = 0
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["FRI"] = 0;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }
        else{
            fridayFlag = true
            self.friButton.selected = true;
            self.weekDaysArray[5] = 1
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["FRI"] = 1;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }

        
    }
    @IBAction func SsturdayButton(sender: AnyObject) {
        if(self.saturdayFlag){
            saturdayFlag = false
            self.satButton.selected = false;
            self.weekDaysArray[6] = 0
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["SAT"] = 0;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }
        else{
            saturdayFlag = true
            self.satButton.selected = true;
            self.weekDaysArray[6] = 1
            var query = PFQuery(className:"reminderClass")
            println(reminderObjId)
            query.getObjectInBackgroundWithId(self.reminderObjId as String) {
                (reminderObj: PFObject!, error: NSError!) -> Void in
                if error != nil {
                    NSLog("%@", error)
                    println("pluserror")
                } else {
                    reminderObj["SAT"] = 1;
                    reminderObj["weekDayArray"] = self.weekDaysArray;
                    reminderObj.saveInBackground()
                    println("plussuccess")
                    
                }
            }
            
        }

        
    }

  
        
        
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
            println("inside segue")
            if segue.identifier == "NavToReminderScreen2" {
               
                let destinationController = segue.destinationViewController as! setYourRemindersViewController
                destinationController.reminders = self.reminderCounter
            }

            
        }

    
    
    // to remove the satus bar
    override func prefersStatusBarHidden() -> Bool {
        
        return true;
    }
  
    @IBAction func skipForNow(sender: AnyObject) {
        
        var query = PFQuery(className:"reminderClass")
        println(reminderObjId)
        query.getObjectInBackgroundWithId(self.reminderObjId as String) {
            (reminderObj: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
                println("pluserror")
            } else {
                reminderObj["skipReminders"] = true
                reminderObj.saveInBackground()
                var storyboard: UIStoryboard = UIStoryboard(name: "Dashboards", bundle: nil)
                var vc = storyboard.instantiateViewControllerWithIdentifier("mainDashBoard") as! MainDashboardViewController
                self.showViewController(vc, sender: self)
                
            }
        }

        
        
        
    }
   

}
