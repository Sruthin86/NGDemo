//
//  setYourRemindersViewController.swift
//  Nail Goals
//
//  Created by Sparty on 5/3/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class setYourRemindersViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate  {
   

    @IBOutlet var timePicker: UIDatePicker!
    @IBOutlet var tableView: UITableView!
    var reminders: Int?
    var animate: UIDynamicAnimator?
    var flag: Bool =  true;
    var currentTableIndex: Int = 20
    var remindersArray: [String]?
    var reminderTime: String = ""{
        didSet{
            println("About to set totalSteps to \(reminderTime) ")
            self.displayTime(currentTableIndex)
        }
        
    }
    var initialLoad: Bool = true
    var initialtouch: Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
         NSUserDefaults.standardUserDefaults().setObject(self.reminders!, forKey: knoOfReminders)
        self.remindersArray = Array(count: self.reminders!, repeatedValue: "")
        self.tableView.scrollEnabled = true
        self.timePicker.datePickerMode = UIDatePickerMode.Time
        animate = UIDynamicAnimator(referenceView: self.view)
        self.UpdatePosition(self.timePicker)
        println("afterTimer")
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("moveButton"), userInfo: nil, repeats: false)
        //println(reminders!)
        
        //self.timePicker.hidden = true;
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        println("intable")
        return reminders! + 2
       
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
        UITableViewCell {
            
            if(indexPath.row == 0){
            var cell: RemindersScreenHeaderTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell1") as! RemindersScreenHeaderTableViewCell
            
            return cell
            }
            
            
            if(indexPath.row >= 1 && indexPath.row <= reminders! ){
                println("froyo")
                println(reminders!)
                var cell: RemindersScreenSetRemindersTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell2") as! RemindersScreenSetRemindersTableViewCell
                println("froyo11")
                return cell
            }

            
            if(indexPath.row > reminders!){
                println("froyo1")
                var cell: RemindersScreenNextButtonTableViewCell = tableView.dequeueReusableCellWithIdentifier("cell3") as! RemindersScreenNextButtonTableViewCell
                
                return cell
            }
            
            else
            {
                return UITableViewCell()
            }

            
            
            
            
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == 0){
            return 180.0;
        }
        
        if(indexPath.row >= 1 && indexPath.row <= 10 ){
         
            return 64.0;
        }
        else{
            return 84.0;
        }
        
    }

    @IBAction func pickTime(sender: AnyObject) {
        println("TimePicker")
        var dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        reminderTime = dateFormatter.stringFromDate(timePicker.date)
       

    }
    
    
    func createAnimation(X:CGFloat, Y:CGFloat){
        animate?.removeAllBehaviors()
        println("animation")
        var gravity = UIGravityBehavior(items: [self.timePicker])
        
        gravity.gravityDirection = CGVectorMake(0, X)
        animate?.addBehavior(gravity)
        let collisionBehaviour:UICollisionBehavior = UICollisionBehavior(items: [self.timePicker])
        collisionBehaviour.addBoundaryWithIdentifier("sideBarBoundary", fromPoint: CGPointMake(self.view.frame.origin.x, Y), toPoint: CGPointMake(self.view.frame.origin.x + self.view.frame.width, Y))
        animate?.addBehavior(collisionBehaviour)
        
        
    }
    
   func moveButton() {
    println("move")
        if(flag){
            if(self.initialLoad){
                self.timePicker.layer.zPosition = -1
                self.initialLoad = false
            }
            var BoundaryX: CGFloat = 1
            var BoundaryY: CGFloat  =  900.0
            createAnimation(BoundaryX, Y: BoundaryY )
            
            flag = false
        }
        else{
            self.timePicker.layer.zPosition = 1
            var BoundaryX: CGFloat  = -1
            var BoundaryY: CGFloat  =  500.0
            createAnimation(BoundaryX, Y: BoundaryY )
            flag = true
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row >= 1 && indexPath.row <= reminders ){
            self.moveButton()
            self.currentTableIndex = indexPath.row
        }
       
    }
    
    
    
   func UpdatePosition(DynView: UIDatePicker){
    
   
        println(view.frame.origin.y)
        var positionX: CGFloat = 0
        var positionY: CGFloat = 800.0
        println("XY")
        println(positionX)
        println(positionY)
        view.frame.origin.x = positionX
        view.frame.origin.y = positionY
//
//        
//        
//        let xPosition = DynView.frame.origin.x
//        
//        //View will slide 20px up
//        let yPosition = DynView.frame.origin.y + 800
//        
//        let height = DynView.frame.size.height
//        let width = DynView.frame.size.width
//        
//        UIView.animateWithDuration(0.0, animations: {
//            
//            DynView.frame = CGRectMake(xPosition, yPosition, height, width)
//        
//        })
//        DynView.layer.zPosition = 1
//        
//        
//        
    }
    
    func displayTime(currIndex:Int){
        let rowToSelect:NSIndexPath = NSIndexPath(forRow: currIndex, inSection: 0);
        let currentCell = tableView.cellForRowAtIndexPath(rowToSelect) as! RemindersScreenSetRemindersTableViewCell;
        currentCell.tapToselect.setTitle(reminderTime, forState: UIControlState.Normal)
        var query = PFQuery(className:"reminderClass")
        var reminderObjId =  NSUserDefaults.standardUserDefaults().objectForKey(kreminderObjectId) as! NSString
        self.remindersArray![currIndex - 1] = self.reminderTime
        query.getObjectInBackgroundWithId(reminderObjId as String) {
            (reminderObj: PFObject!, error: NSError!) -> Void in
            if error != nil {
                NSLog("%@", error)
                println("pluserror")
            } else {
                reminderObj["remindersArray"] = self.remindersArray;
                reminderObj.saveInBackground()
                
                println("plussuccess")
                
            }
        }
        
        
    }
    
    
    // to remove the satus bar
    override func prefersStatusBarHidden() -> Bool {
        
        return true;
    }

    @IBAction func nextButton(sender: AnyObject) {
        
        var storyboard: UIStoryboard = UIStoryboard(name: "Dashboards", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("mainDashBoard") as! MainDashboardViewController
        self.showViewController(vc, sender: self)
    }

   
}
