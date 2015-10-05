//
//  WalkthroughSetYourGoalsViewController.swift
//  Nail Goals
//
//  Created by Sparty on 5/13/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class WalkthroughSetYourGoalsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var objectId = NSUserDefaults.standardUserDefaults().objectForKey(kobjectId) as! NSString
    var daysInGoal: [Int]  = []
    @IBOutlet var claendarHeaderView: UIView!
    @IBOutlet var monthAndYearLabel: UILabel!// label for month and year in the calendar header view. To display the name of the month and year on the calendar
    var startDateFlag = true
    var startDate = ""
    var endDate = ""
    var skipDays = 0
    var currentMonth = 0
    var nextMonth = 0
    var thisMonth = 0
    var thisYear =  0
    var nextYear = 0
    var calender = [Int]()
    var currentDate = NSDate()
    var monthName = ""
    var preMonth = 0
    var preYear = 0
    var compareMonth = 0
    var compareYear = 0
    var datesArray = [Int]()
    var monthsArray = [Int]()
    var yearsArray = [Int]()
    var selectionFalg  = false
    var indexpathArray = [Int]()
    var previousDatesarray = [Int]()
    
    @IBOutlet var startDateInput: UILabel!
    @IBOutlet var setGaolsView1: UIView!
    @IBOutlet var setGoalsView5: UIView!
    
    @IBOutlet var setViewGoals2: UIView!
    @IBOutlet var setViewGoals3: UIView!
    @IBOutlet var startDateLabelScreen5: UILabel!
    @IBOutlet var endDateLabelScreen5: UILabel!

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var calObject =   calenderObject()
        calender = calObject.calweekDayFromDate(currentDate)
        compareMonth = calender[0]
        compareYear = calender[2]
        //UpdatePosition( self.setGaolsView1)
        self.collectionView.hidden = true
        self.claendarHeaderView.hidden =  true
        self.setViewGoals2.hidden = true
        self.setViewGoals3.hidden = true
        self.setGoalsView5.hidden = true


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    
    @IBAction func navigateToReminderswkScreen(sender: AnyObject) {
      
     
        var userName = NSUserDefaults.standardUserDefaults().objectForKey(KuserNameKey) as! NSString
        
        var noOfDays: Int = claculateNoOfDaysinGoal(self.startDateLabelScreen5.text!, endDate: self.endDateLabelScreen5.text! )
        
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
                        self.performSegueWithIdentifier("navToremindersWkScreen", sender: self)
                    }
                }
                
                
            }
            else{
                println("errorSavingGoalObject")
            }
            
        }
        
        
        
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        println("in counter")
        return 35
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        var calObject =   calenderObject()
        if(indexPath.row == 0){
            calender = calObject.calweekDayFromDate(currentDate)
            
        }
        else {
            calender = calObject.calculateDay(indexPath.row, stDt: currentDate )
        }
        var weekDay = calender[3]
        var month = calender[0]
        var year = calender[2]
        var dateInCell = "\(calender[0])" + "/" + "\(calender[1])" + "/" + "\(calender[2])"
        
        if(indexPath.row == 0){
            
            monthName = self.getMonthName(month)
        }
        if (currentMonth == 0){
            currentMonth = month
            thisMonth = month
        }
        if(thisYear == 0){
            thisYear = year
        }
        
        if(indexPath.row == 0){
            switch weekDay {
                
            case 1:
                skipDays  = 1
            case 2:
                skipDays = 2
            case 3:
                skipDays = 3
            case 4:
                skipDays  = 4
            case 5:
                skipDays = 4
            case 6:
                skipDays = 6
            case 7:
                skipDays = 7
            default:
                skipDays  = 0
            }
        }
        var daysAdedforSelection = skipDays-1
        if(indexPath.row < skipDays-1 ){
            println("indexPath1")
            println(indexPath.row)
            println(dateInCell)
            var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("dateCell", forIndexPath: indexPath) as! calendarDateCollectionViewCell
            cell.dateLabel.text = ""
            self.datesArray.append(0)
            self.monthsArray.append(0)
            self.yearsArray.append(0)
            cell.backgroundColor = UIColor( red: 251/255, green: 251/255, blue:251/255, alpha: 1.0 )
            
            
            return cell
        }
            
            
        else {
            println("indexPath2")
            println(indexPath.row)
            println(dateInCell)
            
            var calenderDayInCell: Array<Int> = calObject.calculateDay(indexPath.row - (skipDays - 1), stDt: currentDate)
            if(daysAdedforSelection == -2){
                 calenderDayInCell = calObject.calculateDay(indexPath.row, stDt: currentDate)
            }
            
            var dateInCell = "\(calenderDayInCell[0])" + "/" + "\(calenderDayInCell[1])" + "/" + "\(calenderDayInCell[2])"
            
            var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("dateCell", forIndexPath: indexPath) as! calendarDateCollectionViewCell
            var day = String(calenderDayInCell[1])
            self.datesArray.append(day.toInt()!)
            self.monthsArray.append(calenderDayInCell[0])
            self.yearsArray.append(calenderDayInCell[2])
            cell.dateLabel.text = day
            self.monthAndYearLabel.text = monthName + "  \(thisYear)"
            self.calculateDateRange(startDate, enddt: endDate, compareDt: dateInCell, idPathNumber: indexPath.row)
            self.highlightStartDate(startDate, compareDt: dateInCell, idPathNumber: indexPath.row)
            cell.backgroundColor = UIColor( red: 251/255, green: 251/255, blue:251/255, alpha: 1.0 )
            
            if(self.indexpathArray.count > 0 ) {
                if (contains (self.indexpathArray, indexPath.row)){
                    println("green")
                    println(dateInCell)
                    cell.backgroundColor = UIColor( red: 43/255, green: 178/255, blue:212/255, alpha: 1.0 )
                }
                
                
            }
            if(contains (self.previousDatesarray, indexPath.row)){
                
                cell.backgroundColor = UIColor( red: 255/255, green: 255/255, blue:255/255, alpha: 1.0 )
                
                
            }
            return cell
        }
        
        
        
        
    }
    
    func highlightStartDate(stdt: String, compareDt: String, idPathNumber: Int) {
        
        if(stdt == "" ){
            //return nothing
        }
        else{
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let startDt:NSDate = dateFormatter.dateFromString(stdt)!
            let compDt = dateFormatter.dateFromString(compareDt)!
            if startDt.compare(compDt) == NSComparisonResult.OrderedDescending
            {
                self.previousDatesarray.append(idPathNumber)
            }
            if ( startDt == compDt){
                self.indexpathArray.append(idPathNumber)
            }
            
        }
        
    }
    
    func calculateDateRange(stdt: String ,  enddt: String, compareDt: String , idPathNumber: Int) -> Bool{
        
        if(stdt == "" || enddt == ""){
            return false
        }
        else {
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let startDt:NSDate = dateFormatter.dateFromString(stdt)!
            let endDt:NSDate = dateFormatter.dateFromString(enddt)!
            let compDt = dateFormatter.dateFromString(compareDt)!
            
            if ( startDt == compDt){
                self.indexpathArray.append(idPathNumber)
            }
            if(endDt == compDt){
                println("enddt eq compare dt")
                self.indexpathArray.append(idPathNumber)
            }
            if startDt.compare(compDt) == NSComparisonResult.OrderedAscending
            {
                if endDt.compare(compDt) == NSComparisonResult.OrderedDescending
                {
                    self.indexpathArray.append(idPathNumber)
                    return true
                }else{
                    return false
                }
                
                
            }else
            {
                return false
            }
        }
        
        
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        println("reusableView")
        var  headerView: CalendarHeaderCollectionReusableView =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier:"Header", forIndexPath:indexPath) as! CalendarHeaderCollectionReusableView
        
        return headerView
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        
        if(startDateFlag){
            startDate = "\(monthsArray[indexPath.row])" + "/" + "\(datesArray[indexPath.row])" + "/" +  "\(yearsArray[indexPath.row])"
            endDate = ""
            self.startDateInput.text =  formatDateForUI(startDate)
            self.startDateLabelScreen5.text = formatDateForUI(startDate)
//            self.endDateInput.text =  ""
//            self.selectEndDate.text = "Select End Date"
            self.startDateFlag = false
            self.previousDatesarray.removeAll(keepCapacity: false)
            self.indexpathArray.removeAll(keepCapacity: false)
//            self.nextButton.hidden = true
            self.collectionView.reloadData()
            transitionToView3();
            
            //            cell.backgroundColor = UIColor( red: 43/255, green: 178/255, blue:212/255, alpha: 1.0 )
            
            
        }
        else {
            endDate = "\(monthsArray[indexPath.row])" + "/" + "\(datesArray[indexPath.row])" + "/" +  "\((yearsArray[indexPath.row]))"
            startDateFlag = true
            self.endDateLabelScreen5.text = formatDateForUI(endDate)
            self.collectionView.reloadData()
             var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("showSelection"), userInfo: nil, repeats: false)

            
            
            
            
        }
        
        
        
    }
    func transitionToView3(){
        self.setGaolsView1.hidden = true
        self.setViewGoals2.hidden = true
        self.setViewGoals3.hidden = false
        //UpdatePosition(self.setViewGoals3)
        
    }
    
    func transitionToView5(){
        self.setGaolsView1.hidden = true
        self.setViewGoals2.hidden = true
        self.setViewGoals3.hidden = true
        self.setGoalsView5.hidden = false
        //UpdatePosition(self.setGoalsView5)
        
    }
    func showSelection(){
        self.collectionView.hidden = true
        self.claendarHeaderView.hidden =  true
        transitionToView5()
        
    }
    
    
    
    
    @IBAction func calendarNextButton(sender: AnyObject) {
        self.previousDatesarray.removeAll(keepCapacity: false)
        indexpathArray.removeAll(keepCapacity: false)
        monthsArray.removeAll(keepCapacity: false)
        yearsArray.removeAll(keepCapacity: false)
        datesArray.removeAll(keepCapacity: false)
        if(currentMonth != 12){
            nextMonth = currentMonth + 1
            currentMonth = 0
            nextYear = thisYear
        }
        else {
            nextMonth = 1
            nextYear = thisYear + 1
            currentMonth = 0
            thisYear = 0
        }
        var date = "\(nextMonth)" + "/" + "01/" + "\(nextYear)"
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        currentDate = dateFormatter.dateFromString(date)!
        collectionView.reloadData()
        
        
        
    }
    
    @IBAction func claendarPreviousButton(sender: AnyObject) {
        self.previousDatesarray.removeAll(keepCapacity: false)
        indexpathArray.removeAll(keepCapacity: false)
        datesArray.removeAll(keepCapacity: false)
        monthsArray.removeAll(keepCapacity: false)
        yearsArray.removeAll(keepCapacity: false)
        if(compareMonth == currentMonth && compareYear == thisYear){
            var todaysDate = NSDate()
            currentDate = todaysDate
            collectionView.reloadData()
        }else{
            if(currentMonth != 1){
                preMonth = currentMonth - 1
                currentMonth = 0
                preYear = thisYear
            }else {
                preMonth = 12
                preYear = thisYear - 1
                thisYear = 0
                currentMonth = 0
            }
            if(compareMonth == preMonth && compareYear == preYear){
                var todaysDate = NSDate()
                currentDate = todaysDate
                collectionView.reloadData()
            }else{
                var date = "\(preMonth)" + "/" + "01/" + "\(preYear)"
                let dateFormatter = NSDateFormatter()
                dateFormatter.dateFormat = "MM-dd-yyyy"
                currentDate = dateFormatter.dateFromString(date)!
                collectionView.reloadData()
            }
            
            
        }
        
        
    }
    


    @IBAction func selectStartDateV1(sender: AnyObject) {
        self.setGaolsView1.hidden = true
        self.setGoalsView5.hidden = true
        self.setViewGoals3.hidden = true
        self.claendarHeaderView.hidden =  false
        self.collectionView.hidden = false
        self.setViewGoals2.hidden = false
        //UpdatePosition(self.setViewGoals2)
        
        
    }

    
    func UpdatePosition(calView: UIView){
     
        var positionX: CGFloat = 0.0
        var positionY: CGFloat = 0.0
        println(positionX)
        println(positionY)
        calView.frame.origin.x = positionX
        calView.frame.origin.y = positionY
      
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
    

    func getNameOftheMonth(month:Int)-> String{
        var monthName: String = ""
        switch month{
        case 1:
            monthName = "January "
        case 2:
            monthName = "Febuary "
        case 3:
            monthName = "March "
        case 4:
            monthName = "April "
        case 5:
            monthName = "May "
        case 6:
            monthName = "June "
        case 7:
            monthName = "July "
        case 8:
            monthName = "August "
        case 9:
            monthName = "September "
        case 10:
            monthName = "October "
        case 11:
            monthName = "November "
        default:
            monthName = "December "
            
        }
        return monthName
    }

    

  
}
