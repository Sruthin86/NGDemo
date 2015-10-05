//
//  BiteTrackerViewController.swift
//  Nail Goals
//
//  Created by Sparty on 6/4/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class BiteTrackerViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var biteFreeDaysLabel: UILabel!
    
    @IBOutlet var biteDaysLabel: UILabel!
    
    
    var biteDays: Int?
    var biteFreeDays: Int?
    var noOfDaysArray = [Int]()
    var startDate: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        self.biteFreeDaysLabel.text = "\(biteFreeDays!)"
        println(biteFreeDays)
        println(self.biteFreeDaysLabel.text)
        self.biteDaysLabel.text = "\(biteDays!)"
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return noOfDaysArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("BiteCell", forIndexPath: indexPath) as! BiteTrackerCollectionViewCell
        cell.counterLabel.text = "\(noOfDaysArray[indexPath.row])"
        
        cell.dayLabel.text = "Day " + "\(indexPath.row + 1)"
//        cell.monthAndDayLabel.text = "\(self.getMonth(startDate!, days: indexPath.row))" + "\(self.getDay(startDate!, days: indexPath.row))"
//        cell.weekDayLabel.text = "\(self.getDayOfWeek(startDate!, days: indexPath.row))"
        return cell
        
        
        
        
        
        
    }
    
    
    
    
    
    
    
    func getDayOfWeek(startDate:String, days: Int)->String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let cal = NSCalendar.currentCalendar()
        let startDt:NSDate = dateFormatter.dateFromString(startDate)!
        let unit:NSCalendarUnit = NSCalendarUnit.CalendarUnitDay
        
        let components = cal.dateByAddingUnit(unit, value: days, toDate: startDt, options: nil)
        var month =  cal.components(NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekday, fromDate: components!)
        var weekDayName = getNameOftheWeekDay(month.weekday)
        return weekDayName
    }
    
    func getDay(startDate: String, days: Int)->Int{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let cal = NSCalendar.currentCalendar()
        let startDt:NSDate = dateFormatter.dateFromString(startDate)!
        let unit:NSCalendarUnit = NSCalendarUnit.CalendarUnitDay
        
        let components = cal.dateByAddingUnit(unit, value: days, toDate: startDt, options: nil)
        var month =  cal.components(NSCalendarUnit.CalendarUnitMonth | NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitWeekday, fromDate: components!)
        
        return month.day
    }
    
    func getMonth(startDate: String, days: Int)->String{
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MM-dd-yyyy"
        let cal = NSCalendar.currentCalendar()
        let startDt:NSDate = dateFormatter.dateFromString(startDate)!
        let unit:NSCalendarUnit = NSCalendarUnit.CalendarUnitDay
        
        let components = cal.dateByAddingUnit(unit, value: days, toDate: startDt, options: nil)
        var month =  cal.components(NSCalendarUnit.CalendarUnitDay | NSCalendarUnit.CalendarUnitDay, fromDate: components!)
        
        var monthName = getNameOftheMonth(month.month)
        return monthName
        
    }
    
    
    
    func getNameOftheMonth(month:Int)-> String{
        var monthName: String = ""
        switch month{
        case 1:
            monthName = "Jan "
        case 2:
            monthName = "Feb "
        case 3:
            monthName = "Mar "
        case 4:
            monthName = "Apr "
        case 5:
            monthName = "May "
        case 6:
            monthName = "June "
        case 7:
            monthName = "July "
        case 8:
            monthName = "Aug "
        case 9:
            monthName = "Sep "
        case 10:
            monthName = "Oct "
        case 11:
            monthName = "Nov "
        default:
            monthName = "Dec "
            
        }
        return monthName
    }
    
    func getNameOftheWeekDay(weekDay:Int)-> String{
        var monthName: String = ""
        switch weekDay{
        case 0:
            monthName = "Sun "
        case 1:
            monthName = "Mon "
        case 2:
            monthName = "Tue "
        case 3:
            monthName = "Wed "
        case 4:
            monthName = "Thu "
        case 5:
            monthName = "Fri "
        case 6:
            monthName = "Sat "
            
            
        default:
            monthName = " "
            
        }
        return monthName
    }
    
    

    


}
