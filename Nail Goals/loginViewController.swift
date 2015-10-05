//
//  loginViewController.swift
//  Nail Goals
//
//  Created by Sparty on 4/18/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit



class loginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var userName: UITextField!
    @IBOutlet var password: UITextField!
    var overlayView = UIView()
    var activityIndicator = UIActivityIndicatorView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.userName.delegate = self;
        self.password.delegate = self;
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signInFunction(sender: AnyObject) {
        
        if(self.userName.text.isEmpty || self.password.text.isEmpty){
            
            let alertMessage = UIAlertController(title: "", message: "Please enter your username and password to log in.", preferredStyle: .Alert);
            alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            self.presentViewController(alertMessage, animated: true, completion: nil)

            
        }
        
        else {
            self.showOverlay(self.overlayView)
            PFUser.logInWithUsernameInBackground(self.userName.text,  password: self.password.text){
                (user: PFUser!, error: NSError!) -> Void in
                
                if user != nil{
                    self.hideOverlayView()
                    println(user)
                    

//                    Add the code when goal Class is ready
                    var query = PFQuery(className:"NailGoalsUser")
                    query.whereKey("userName", equalTo:self.userName.text)
                    query.getFirstObjectInBackgroundWithBlock {
                        (object: PFObject!, error: NSError!) -> Void in
                        if object != nil {
                            NSUserDefaults.standardUserDefaults().setObject(self.userName.text, forKey: KuserNameKey)
                            var firstName = object["FirstName"] as! NSString
                            var stDate = object["startDate"]as! NSString
                            var objectId =  object.objectId as NSString
                            var goalsQuery = PFQuery(className:"goalClass")
                            goalsQuery.whereKey("userName", equalTo:self.userName.text)
                            println(goalsQuery)
                            goalsQuery.whereKey("startDate", equalTo:stDate)
                            goalsQuery.getFirstObjectInBackgroundWithBlock {
                                (gaolObject: PFObject!, error: NSError!) -> Void in
                                if object != nil {
                                    var startDate = gaolObject["startDate"] as! NSString
                                    var endDate = gaolObject["endDate"]   as! NSString
                                    var goalsObjId = gaolObject.objectId as NSString
                                    
                                    println(startDate)
                                    NSUserDefaults.standardUserDefaults().setObject(firstName, forKey: kfirstName)
                                   
                                    NSUserDefaults.standardUserDefaults().setObject(objectId, forKey: kobjectId)
                                    NSUserDefaults.standardUserDefaults().setObject(startDate, forKey: kstartDate)
                                    NSUserDefaults.standardUserDefaults().setObject(endDate, forKey: kendDate)
                                    NSUserDefaults.standardUserDefaults().setObject(goalsObjId, forKey: kPresentGoaltId)
                                    
                                    var remquery = PFQuery(className:"reminderClass")
                                    remquery.whereKey("userName", equalTo:self.userName.text)
                                    remquery.getFirstObjectInBackgroundWithBlock {
                                        (remObject: PFObject!, error: NSError!) -> Void in
                                        if object != nil {
                                            var remObjId = remObject.objectId as NSString
                                            println(remObject)
                                            println(remObjId)
                                            NSUserDefaults.standardUserDefaults().setObject(remObjId, forKey: kreminderObjectId)
                                            println( NSUserDefaults.standardUserDefaults().objectForKey(kreminderObjectId) as! NSString)
                                            var storyboard: UIStoryboard = UIStoryboard(name: "Dashboards", bundle: nil)
                                            var vc = storyboard.instantiateViewControllerWithIdentifier("mainDashBoard") as! MainDashboardViewController
                                            self.showViewController(vc, sender: self)
                                            
                                        }
                                        else{
                                            
                                            
                                        }

                                    }
                                   
                                    
                                } else {
                                    println("The getFirstObject2 request failed.")
                                    
                                }
                            }
                            
                        } else {
                            println("The getFirstObject1 request failed.")
                            println(error)
                            
                        }
                    }
                    
                    
                    
                    
               }
                else  {
                    self.hideOverlayView()
                    var errorCode = error.code
                    var message =  "Please try again later"
                    switch errorCode {
                    case 100:
                        message = "Connection failed"
                        break
                    case 101:
                        message = "Darn, looks like your email or password do not match. Please try again! (passwords are case sensitive)"
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

                    println("error")
                    println(error)
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    func DismissKeyboard(){
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    

}
    


