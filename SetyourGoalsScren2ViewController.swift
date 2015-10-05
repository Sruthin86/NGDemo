//
//  SetyourGoalsScren2ViewController.swift
//  Nail Goals
//
//  Created by Sparty on 5/20/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class SetyourGoalsScren2ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
//    var objectId = NSUserDefaults.standardUserDefaults().objectForKey(kobjectId) as! NSString
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
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var startDateInput: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        var calObject =   calenderObject()
        calender = calObject.calweekDayFromDate(currentDate)
        compareMonth = calender[0]
        compareYear = calender[2]

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
        
        let unit:NSCalendarUnit = NSCalendarUnit.CalendarUnitDay
        
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
            var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("dateCell1", forIndexPath: indexPath) as! calendarDateCollectionViewCell1CollectionViewCell
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
            
            var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("dateCell1", forIndexPath: indexPath) as! calendarDateCollectionViewCell1CollectionViewCell
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
        var  headerView: CalendarHeader1CollectionReusableView =  collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier:"Header1", forIndexPath:indexPath) as! CalendarHeader1CollectionReusableView
        
        return headerView
        
        
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var cell : UICollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath)!
        
        if(startDateFlag){
            startDate = "\(monthsArray[indexPath.row])" + "/" + "\(datesArray[indexPath.row])" + "/" +  "\(yearsArray[indexPath.row])"
            endDate = ""
            self.startDateInput.text =  formatDateForUI(startDate);
            self.startDateFlag = false;
            self.previousDatesarray.removeAll(keepCapacity: false);
            self.indexpathArray.removeAll(keepCapacity: false);
            var timerForNav = NSTimer.scheduledTimerWithTimeInterval(0.1, target: self, selector: Selector("navToScreen3"), userInfo: nil, repeats: false)
            //self.collectionView.reloadData()
            
        }
        else {
            endDate = "\(monthsArray[indexPath.row])" + "/" + "\(datesArray[indexPath.row])" + "/" +  "\((yearsArray[indexPath.row]))"
            startDateFlag = true
            
            self.collectionView.reloadData()
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: Selector("showSelection"), userInfo: nil, repeats: false)
            
            
            
            
            
        }
        
        
        
    }
    
    
    func navToScreen3(){
        NSUserDefaults.standardUserDefaults().setObject(self.startDate, forKey: kstartDate);
        NSUserDefaults.standardUserDefaults().synchronize();
        self.performSegueWithIdentifier("showGoalsScreen3", sender: self);

        
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
    
    
    // to remove the satus bar
    override func prefersStatusBarHidden() -> Bool {
        
        return true;
    }

    


}
