//
//  SignUpViewController.swift
//  Nail Goals
//
//  Created by Sparty on 4/18/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit



class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var firstName: UITextField!
    
    @IBOutlet var lastName: UITextField!
    
    @IBOutlet var email: UITextField!
    
    @IBOutlet var password: UITextField!
    
    @IBOutlet var confirmPassword: UITextField!
    var overlayView = UIView()
    
//    var activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad();
        self.firstName.delegate = self;
        self.lastName.delegate = self;
        self.email.delegate = self;
        self.password.delegate = self;
        self.confirmPassword.delegate = self;
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    
    @IBAction func signUpButton(sender: AnyObject) {
   
        
        if(self.email.text.isEmpty || self.firstName.text.isEmpty || self.lastName.text.isEmpty ||        self.password.text.isEmpty || self.confirmPassword.text.isEmpty ){
            
            let alertMessage = UIAlertController(title: "", message: "Required fields can not be left blank", preferredStyle: .Alert);
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
        }
            
        else if(self.password.text != self.confirmPassword.text){
            
            
            let alertMessage = UIAlertController(title: "", message: "passwords do not match", preferredStyle: .Alert);
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)
            
        }
            
        else{
            
            self.showOverlay(self.overlayView)
            NSUserDefaults.standardUserDefaults().setObject(self.email.text, forKey: KuserNameKey)
            NSUserDefaults.standardUserDefaults().setObject(self.password.text, forKey: KpasswordKey)
            NSUserDefaults.standardUserDefaults().setObject(self.firstName.text, forKey: kfirstName)
            
            var Object =  PFObject(className: "NailGoalsUser")
            var user = PFUser()
            user.username = self.email.text
            user.password = self.password.text
            user.email = self.email.text
            //        var PFUserObject =  PfUserObject()
            //        PFUserObject.setUserObject(user)
            user.signUpInBackgroundWithBlock {
                (success: Bool, error: NSError!)-> Void in
                if success == true{
                    
                    Object.setObject(self.firstName.text, forKey: "FirstName")
                    Object.setObject(user, forKey: "user")
                    Object.setObject(self.email.text, forKey: "userName")
                    Object.saveInBackgroundWithBlock {
                        (successObject: Bool, errorObject: NSError!)-> Void in
                        if successObject == true{
                            self.hideOverlayView();
                            println(Object.objectId)
                            println("in success")
                            NSUserDefaults.standardUserDefaults().setObject(Object.objectId, forKey: kobjectId)
                            
                            self.performSegueWithIdentifier("navtoWalkthrough", sender: self)
                            
                            
                        }
                            
                        else{
                            self.hideOverlayView();
                            var errorCode = error.code
                            var message =  "Please try again later"
                            switch errorCode {
                            case 100:
                                message = "Connection failed"
                                break
                            case 125:
                                message = "Please use a valid email address"
                                break
                            case 202:
                                message = "Email address already exists"
                                break
                            default:
                                break
                            }
                            
                            
                            let alertMessage = UIAlertController(title: "", message: "\(message)", preferredStyle: .Alert);
                            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                            
                            self.presentViewController(alertMessage, animated: true, completion: nil)
                            
                            
                            println("errorObject: \(errorObject)")
                        }
                        
                    }
                }
                else{
                    self.hideOverlayView();
                    var errorCode = error.code
                    var message =  "Please try again later"
                    switch errorCode {
                    case 100:
                        message = "Connection failed"
                        break
                    case 125:
                        message = "Invalid Email Address"
                        break
                    case 202:
                        message = "Email Address has already been used! "
                        break
                    default:
                        break
                    }
                    
                    
                    let alertMessage = UIAlertController(title: "", message: "\(message)", preferredStyle: .Alert);
                    alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
                    self.presentViewController(alertMessage, animated: true, completion: nil)
                    
                    
                    
                    println("error :\(error)")
                    
                }
                
            }
        }
        
        
    }
    
    
    func showOverlay(view: UIView) {
        
        overlayView = UIView(frame: self.view.frame)
        overlayView.backgroundColor = UIColor( red: 0, green: 0, blue:0, alpha: 0.15 )
        
        
        imageView.animationImages = [UIImage]()
        for var index = 1; index < 8; index++ {
            var frameName = String(format: "spinner_%05d", index)
            imageView.animationImages?.append(UIImage(named: frameName)!)
        }

        
        
        imageView.frame = CGRect(x: 0, y: 0, width: 85.5, height: 84)
        imageView.center = CGPointMake(self.view.bounds.width / 2, self.view.bounds.height / 2)
       
        self.view.addSubview(overlayView)
         self.view.addSubview(imageView)
        
        imageView.animationDuration = 1
        imageView.startAnimating()

        
        
        //self.view.addSubview(overlayView)  
        
       
    }
    
    func hideOverlayView() {
        imageView.stopAnimating()
        imageView.removeFromSuperview()
        overlayView.removeFromSuperview()
    }
    
}
