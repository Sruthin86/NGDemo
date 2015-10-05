//
//  WelcomeWalkthroughViewController.swift
//  Nail Goals
//
//  Created by Sparty on 4/29/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class WelcomeWalkthroughViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func prefersStatusBarHidden() -> Bool {
        
        return true;
    }
    
    
    @IBAction func navToSetYourGoalsScreen(sender: AnyObject) {
        var storyboard: UIStoryboard = UIStoryboard(name: "Walkthrough Set First Goal", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("SetYourGoalsScreen1") as! SetyourGoalsScren1ViewController
        self.showViewController(vc, sender: self)
    }
    
   

}
