//
//  faceBookViewController.swift
//  Nail Goals
//
//  Created by Sparty on 4/11/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class faceBookViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var permissions = ["public_profile","email","basic_info", "user_about_me"]
        PFFacebookUtils.logInWithPermissions(permissions, block: {
            (user: PFUser!, error: NSError!) -> Void in
            if user == nil {
                NSLog("Uh oh. The user cancelled the Facebook login.")
                println(error)
            } else if user.isNew {
                FBRequestConnection.startForMeWithCompletionHandler { connection, result, error in
                    if (error != nil) {
                        
                    }
                    else{
                        var resultdict = result as? NSDictionary
                        if let fBfirstName = resultdict?["first_name"] as? String {
                            NSUserDefaults.standardUserDefaults().setObject(fBfirstName, forKey: KuserNameKey)
                            
                            NSUserDefaults.standardUserDefaults().setObject(fBfirstName, forKey: kfirstName)
                            println(fBfirstName)
                            //self.performSegueWithIdentifier("fbregistration", sender: self)
                        }
                        
                    }
                }
            } else {
                println("x")
                FBRequestConnection.startForMeWithCompletionHandler { connection, result, error in
                    if (error != nil) {
                        
                    }
                    else{
                        var resultdict = result as? NSDictionary
                        if let fBfirstName = resultdict?["first_name"] as? String {
                            NSUserDefaults.standardUserDefaults().setObject(fBfirstName, forKey: KuserNameKey)
                            
                            NSUserDefaults.standardUserDefaults().setObject(fBfirstName, forKey: kfirstName)
                            //self.performSegueWithIdentifier("fbLogin", sender: self)
                            
                        }
                        
                    }
                }
            }
        })
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}
