//
//  forgotPasswordViewController.swift
//  Nail Goals
//
//  Created by Sparty on 4/25/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class forgotPasswordViewController: UIViewController {

    @IBOutlet var email: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func forgotPassword(sender: AnyObject) {
        
        if(self.email.text.isEmpty){
            
            let alertMessage = UIAlertController(title: "", message: "Please Enter an Email Address", preferredStyle: .Alert);
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
        else {
        
            PFUser.requestPasswordResetForEmailInBackground(self.email.text){
            (success: Bool, error: NSError!) -> Void in
            if (error == nil) {
                let alertMessage = UIAlertController(title: "", message: "Awesome! Almost done now! Please check your email and click the link within to reset your password.", preferredStyle: .Alert);
                alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertMessage, animated: true, completion: nil)
                
            }else {
                let alertMessage = UIAlertController(title: "", message: "Hmmm, the email you entered does not seem to be working. Please check that it's correct and try again, or sign up if you're a new user.", preferredStyle: .Alert);
                alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                self.presentViewController(alertMessage, animated: true, completion: nil)
                
            }
        }
      }
    }

    

}
