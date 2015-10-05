//
//  ViewController.swift
//  Nail Goals
//
//  Created by I.Feynberg on 3/30/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var counter: Int = 1
    var pageViewController : UIPageViewController?
    var pageTitles : Int = 5
    var currentIndex : Int = 0
    var pageCounter : Int = 0
    var index: Int = 0
    var tintColor = UIColor( red: 221/255, green: 221/255, blue:221/255, alpha: 1.0 )
    var tintSelectedColor = UIColor( red: 17/255, green: 175/255, blue:173/255, alpha: 1.0 )
    let imageName = "home_screen_background1"
    let pageControl: UIPageControl = UIPageControl.appearance()
    var tourTextDescription : Array<String> = ["1Lorem ipsum dolor sit amet, sit morbi wisi magna, sit ligula ultricies mus vitae id vestibulum, fringilla nec molestie vitae varius fermentum, erat turpis dignissimos. Urna nonummy donec pellentesque nascetur, nunc sem, sociis vestibulum sodales congue in pharetra pede, pretium ac fames", "2Lorem ipsum dolor sit amet, sit morbi wisi magna, sit ligula ultricies mus vitae id vestibulum, fringilla nec molestie vitae varius fermentum, erat turpis dignissimos. Urna nonummy donec pellentesque nascetur, nunc sem, sociis vestibulum sodales congue in pharetra pede, pretium ac fames", "3Lorem ipsum dolor sit amet, sit morbi wisi magna, sit ligula ultricies mus vitae id vestibulum, fringilla nec molestie vitae varius fermentum, erat turpis dignissimos. Urna nonummy donec pellentesque nascetur, nunc sem, sociis vestibulum sodales congue in pharetra pede, pretium ac fames", "4Lorem ipsum dolor sit amet, sit morbi wisi magna, sit ligula ultricies mus vitae id vestibulum, fringilla nec molestie vitae varius fermentum, erat turpis dignissimos. Urna nonummy donec pellentesque nascetur, nunc sem, sociis vestibulum sodales congue in pharetra pede, pretium ac fames", "5Lorem ipsum dolor sit amet, sit morbi wisi magna, sit ligula ultricies mus vitae id vestibulum, fringilla nec molestie vitae varius fermentum, erat turpis dignissimos. Urna nonummy donec pellentesque nascetur, nunc sem, sociis vestibulum sodales congue in pharetra pede, pretium ac fames"]
   
    
    @IBOutlet var textView: UITextView!
   
    
    override func viewDidLoad() {
        self.textView.hidden = true
        super.viewDidLoad()
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        pageViewController!.delegate = self
        let startingViewController: tourViewControllerhelper = viewControllerAtIndex(0)!
        
        let viewControllers: NSArray = [startingViewController]
        pageViewController!.setViewControllers(viewControllers as [AnyObject], direction: .Forward, animated: false, completion: nil)
        
        pageViewController!.view.frame = CGRectMake(0, 100, view.frame.size.width, view.frame.size.height-300);
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
        pageControl.pageIndicatorTintColor = tintColor
        pageControl.currentPageIndicatorTintColor = tintSelectedColor
        var timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func update()   {
        
        
        
        let pageContentViewController = tourViewControllerhelper()
        var i = pageContentViewController.pageIndex
        
        
        if index >= 4{
            index = 0
            
        }
        else{
            index++
        }
        
        let startingViewController: tourViewControllerhelper = viewControllerAtIndex(index)!
        
        let viewControllers: NSArray = [startingViewController]
        self.pageViewController?.setViewControllers(viewControllers as [AnyObject], direction: .Forward , animated: true, completion: nil)
        
        
        
    }
    
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        
        
        
        index = (viewController as! tourViewControllerhelper).pageIndex
        
        
        if (index == 0) || (index == NSNotFound) {
            currentIndex--
            return viewControllerAtIndex(4)
            
        }
        //        index--
        //        pageCounter--
        
        return viewControllerAtIndex(index - 1)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        
        
        
        index = (viewController as! tourViewControllerhelper).pageIndex
        
        if (index == NSNotFound || index == 4) {
            currentIndex++
            return viewControllerAtIndex(0)
            
        }
        
        //        index++
        //        pageCounter++
        
        return viewControllerAtIndex(index + 1)
    }
    func viewControllerAtIndex(index: Int) -> tourViewControllerhelper?
    {
        if self.pageTitles == 0 || index >= self.pageTitles
        {
            return nil
        }
        
        
        // Create a new view controller and pass suitable data.
        let pageContentViewController = tourViewControllerhelper()
        
        pageContentViewController.titleText = tourTextDescription[index]
        pageContentViewController.pageIndex = index
        currentIndex = index
        
        
        
        return pageContentViewController
    }
    
    func presentationCountForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        return 5
    }
    
    func presentationIndexForPageViewController(pageViewController: UIPageViewController) -> Int
    {
        
        return currentIndex
    }
    
    
    
}

