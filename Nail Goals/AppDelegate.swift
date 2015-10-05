//
//  AppDelegate.swift
//  Nail Goals
//
//  Created by I.Feynberg on 3/30/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit
let KuserNameKey = "userNameKey";
let KpasswordKey = "passwordKey";
let kfirstName = "firstName";
let kstartDate = "startDate";
let kendDate = "endDate";
let kstartDateUI = "startDateForUI";
let kendDateUI = "endDateForUI";
let kobjectId = "objectId";
let kuserObjectId = "userObjectID";
let knoOfReminders = "noOfReminders";
let kreminderObjectId = "kreminderObjectId";
let kleftHand = "false";
let kPresentGoaltId = "kPresentGoaltId";
let kskipRemindersFalg: Bool = false ;
let knoOfDaysInGoalArray = [Int]()
let kreminderTimesArray: [String] = []


//images for spinner
let imageName = "spinner_00001.png"
let image = UIImage(named: imageName)
let imageView = UIImageView(image: image!)

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        Parse.setApplicationId("6ebWIRLVUvQrUpSd979ZVKrz3TKJzplCiG2ZUk5T", clientKey: "4IsBwIiPVt5HFPy3fhsJL6NVPuN3lmPpKo8jIehH")
        PFFacebookUtils.initializeFacebook()

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func application(application: UIApplication,
        openURL url: NSURL,
        sourceApplication: String?,
        annotation: AnyObject?) -> Bool {
            return FBAppCall.handleOpenURL(url, sourceApplication:sourceApplication,
                withSession:PFFacebookUtils.session())
    }
    
    func applicationDidBecomeActive(application: UIApplication) { 
        FBAppCall.handleDidBecomeActiveWithSession(PFFacebookUtils.session())
    }

    func applicationWillTerminate(application: UIApplication) { 
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

