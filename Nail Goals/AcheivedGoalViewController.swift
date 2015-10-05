//
//  AcheivedGoalViewController.swift
//  Nail Goals
//
//  Created by Sparty on 5/27/15.
//  Copyright (c) 2015 Think Better Labs, Inc. All rights reserved.
//

import UIKit

class AcheivedGoalViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        if(indexPath.row == 0){
            var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("PastGoalTrackerCell", forIndexPath: indexPath) as! AcheivedGoalCollectionViewCell
            return cell
        }
        else if(indexPath.row == 1){
            var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("PastGoalTrackerCell2", forIndexPath: indexPath) as! AcheivedGoal2CollectionViewCell
            return cell
        }
        else if(indexPath.row == 2){
            var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("PastGoalTrackerCell3", forIndexPath: indexPath) as! AcheivedGoal3CollectionViewCell
            return cell
        }
        else if(indexPath.row == 3){
            var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("PastGoalTrackerCell4", forIndexPath: indexPath) as! AcheivedGoal4CollectionViewCell
            return cell
        }
        else if(indexPath.row == 4){
            var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("PastGoalTrackerCell5", forIndexPath: indexPath) as! AcheivedGoal5CollectionViewCell
            return cell
        }
        else {
            var cell =  collectionView.dequeueReusableCellWithReuseIdentifier("PastGoalTrackerCell6", forIndexPath: indexPath) as! AcheivedGoal6CollectionViewCell
            return cell
        }

       
        
        
    }

}
