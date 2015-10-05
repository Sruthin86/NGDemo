//
//  tourViewControllerHelper.swift
//  Nail Goals
//
//  Created by Sparty on 4/11/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import Foundation

class tourViewControllerhelper: UIViewController{
    var titleText = " Taylor Swift"
    var pageIndex : Int = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel(frame: CGRectMake(50, 0, view.frame.width-100, view.frame.width-75))
        label.numberOfLines = 7
        label.textColor = UIColor.blackColor()
        label.text = titleText
        label.textAlignment = .Center
        label.font = UIFont(name: "AmericanTypewriter-Light", size: CGFloat(18))
        view.addSubview(label)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}